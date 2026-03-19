#!/bin/bash

_info()    { printf "\n\033[38;5;081m %s\033[0m\n" "$@"; }
_success() { printf "\n\033[38;5;076m %s\033[0m\n" "$@"; }
_error()   { printf "\n\033[38;5;196m %s\033[0m\n" "$@"; }
_warning() { printf "\n\033[38;5;214m %s\033[0m\n" "$@"; }
