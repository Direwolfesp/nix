#!/usr/bin/env nu

let SOURCE = "alsa_input.usb-CMEDIA_Q9-1-00.mono-fallback"
let MUTED_SOUND = $"($env.HOME)/.config/hypr/scripts/mic_muted.mp4"
let UNMUTED_SOUND = $"($env.HOME)/.config/hypr/scripts/mic_activated.mp4"

let MPV_FLAGS = [
  --no-config
  --no-video
  --volume=80
]

pactl set-source-mute $SOURCE toggle

let muted = pactl -f json list sources
  | from json
  | where name =~ $SOURCE
  | get mute
  | first
  | into bool 

if $muted {
  mpv ...$MPV_FLAGS $MUTED_SOUND
} else {
  mpv ...$MPV_FLAGS $UNMUTED_SOUND
}
