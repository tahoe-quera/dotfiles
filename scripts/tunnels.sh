#!/bin/bash

_start() { ssh -fN "$1-supervisor"; }

_stop() {
  for t in qtrl telem sorting holo; do
    pkill -f "ssh -fN $t-supervisor" 2>/dev/null || true
  done
}

case "${1:-}" in
  start)
    shift
    [[ $# -eq 0 ]] && set -- --all
    for flag in "$@"; do
      case "$flag" in
        --all)     _start qtrl; _start telem; _start sorting; _start holo ;;
        --qtrl)    _start qtrl ;;
        --telem)   _start telem ;;
        --sorting) _start sorting ;;
        --holo)    _start holo ;;
        *) echo "unknown flag: $flag" >&2; exit 1 ;;
      esac
    done ;;
  stop) _stop ;;
  *)
    echo "usage: tunnels start [--all|--qtrl|--telem|--sorting|--holo]" >&2
    echo "       tunnels stop" >&2
    exit 1 ;;
esac
