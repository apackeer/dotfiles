#!/bin/zsh

set -u

readonly remote_host="${HERDR_CONFIG_REMOTE_HOST:-aidlc-dev-1}"
readonly remote_path="${HERDR_CONFIG_REMOTE_PATH:-.config/herdr/config.toml}"
readonly config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/herdr"
readonly config_path="$config_dir/config.toml"
readonly herdr_bin="/opt/homebrew/bin/herdr"

sync_remote_config() {
  local mode="${1:-quiet}"
  local temp_config

  mkdir -p "$config_dir" || return 1
  temp_config="$(mktemp "$config_dir/config.toml.remote.XXXXXX")" || return 1

  if ! scp -q \
    -o BatchMode=yes \
    -o ConnectTimeout=4 \
    -o ConnectionAttempts=1 \
    "$remote_host:$remote_path" \
    "$temp_config"; then
    rm -f "$temp_config"
    [[ "$mode" == "verbose" ]] && print -u2 "Could not fetch Herdr config from $remote_host."
    return 1
  fi

  if ! HERDR_CONFIG_PATH="$temp_config" "$herdr_bin" config check >/dev/null 2>&1; then
    rm -f "$temp_config"
    [[ "$mode" == "verbose" ]] && print -u2 "Remote Herdr config is invalid; keeping the local copy."
    return 1
  fi

  if [[ -f "$config_path" ]] && cmp -s "$temp_config" "$config_path"; then
    rm -f "$temp_config"
    [[ "$mode" == "verbose" ]] && print "Herdr config is already in sync."
    return 0
  fi

  [[ -f "$config_path" ]] && cp -p "$config_path" "$config_path.bak-sync"
  chmod 644 "$temp_config"
  mv -f "$temp_config" "$config_path"
  "$herdr_bin" server reload-config >/dev/null 2>&1 || true

  [[ "$mode" == "verbose" ]] && print "Synced Herdr config from $remote_host."
}

if [[ "${1:-}" == "--sync-only" ]]; then
  sync_remote_config verbose
  exit $?
fi

# No herdr on this machine: open a normal login shell so the terminal still works.
if [[ ! -x "$herdr_bin" ]]; then
  exec "${SHELL:-/bin/zsh}" -l
fi

sync_remote_config quiet || true
exec "$herdr_bin" "$@"
