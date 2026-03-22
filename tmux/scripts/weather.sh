#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

# OpenMeteo weather for Melbourne — replaces Dracula's wttr.in script
# Args ($1-$4) accepted for Dracula compatibility but ignored

API="https://api.open-meteo.com/v1/forecast?latitude=-37.81&longitude=144.96&current=temperature_2m,weather_code&daily=temperature_2m_min,temperature_2m_max&timezone=Australia/Melbourne&forecast_days=1"

data=$(curl -sf --max-time 4 "$API" 2>/dev/null)
[ -z "$data" ] && exit 0

temp=$(echo "$data" | jq -r '.current.temperature_2m | round')
code=$(echo "$data" | jq -r '.current.weather_code')
low=$(echo "$data" | jq -r '.daily.temperature_2m_min[0] | round')
high=$(echo "$data" | jq -r '.daily.temperature_2m_max[0] | round')

# WMO weather code -> nerd font icon
case $code in
  0)          icon="󰖙" ;;       # clear sky
  1|2)        icon="󰖕" ;;       # partly cloudy
  3)          icon="󰖐" ;;       # overcast
  45|48)      icon="󰖑" ;;       # fog
  51|53|55)   icon="󰖖" ;;       # drizzle
  61|63|65)   icon="󰖗" ;;       # rain
  66|67)      icon="󰖗" ;;       # freezing rain
  71|73|75)   icon="󰖘" ;;       # snow
  77)         icon="󰖘" ;;       # snow grains
  80|81|82)   icon="󰖗" ;;       # rain showers
  85|86)      icon="󰖘" ;;       # snow showers
  95|96|99)   icon="󰖝" ;;       # thunderstorm
  *)          icon="󰖐" ;;       # fallback
esac

echo "${icon} ${temp}°C (${low}/${high})"
