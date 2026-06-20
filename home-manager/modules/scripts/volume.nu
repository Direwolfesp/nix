#!/usr/bin/env nu

# Usage example:
# bind = CTRL SHIFT, u, exec, $SCRIPTS/volume.nu --mode up 20 # +20% volume for focused window
# bind = CTRL SHIFT, d, exec, $SCRIPTS/volume.nu --mode down 20 # -20% volume for focused window
# bind = CTRL SHIFT, m, exec, $SCRIPTS/volume.nu --mode togglemute # toggle mute of focused window

use std/log

def modes []: nothing -> list<string> { [ up down set togglemute ] }

def main [
  --mode(-m): string@modes, # oneof: "up", "down", "set", "togglemute"
  volume?: string, # the percent of volume. Ie: '--mode up 10' means +10% and '--mode set 40' means 40%
] {
  if $mode == null or $mode not-in (modes) {
    log critical $"--mode is mandatory and must be one of: (modes)"
    return
  } else if $volume == null and $mode in [ up down set ] {
    log critical "<volume> is needed for modes: up, down, set"
    return
  } else if $volume != null and $mode in [ togglemute ] {
    log critical "<volume> is not needed for modes: togglemute"
    return
  }

  let graphical_pid = hyprctl clients -j
    | from json
    | sort-by focusHistoryID
    | first
    | get pid
    | into int

  log info $"target graphical pid: ($graphical_pid)"

  # query pactl to find the sink-inputs that correspond to the given
  # graphical application
  let sinks_info = pactl -f json list sink-inputs
    | from json
    | where { |entry|
      let pid = $entry.properties."application.process.id"? | default (-1) | into int
      ($pid == $graphical_pid) or (ps
      | where pid == $pid and ppid == $graphical_pid
      | is-not-empty)
    }
    | select index properties."application.process.binary"? volume.front-left.value_percent
    | rename index binary_name volume
    | update volume {|row|
      $row.volume
      | str substring ..(-2)
      | into int
    }

  if ($sinks_info.index | is-empty) {
    log warning "Did not detect any matching sink"
    return
  }

  let vol: string = match $mode {
    up => { "+" ++ $volume ++ "%" },
    down => { "-" ++ $volume ++ "%" },
    set => { $volume ++ "%" },
    togglemute => { if ($sinks_info.volume.0 > 0) { "0%" } else { "100%" } },
    _ => { error make {msg: $"Unknown mode: '($mode)'"} },
  }

  $sinks_info | each {|sink|
    log info $"($sink.binary_name): set-sink-input-volume ($sink.index) ($vol)"
    pactl set-sink-input-volume $sink.index $vol
  } | ignore
}
