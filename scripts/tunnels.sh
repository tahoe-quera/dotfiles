#!/bin/bash

_start() { ssh -fN "$1-supervisor"; }
_kube()  { kubectl port-forward "$@" &>/dev/null & }

_stop() {
  for t in qtrl telem sorting holo; do
    pkill -f "ssh -fN $t-supervisor" 2>/dev/null || true
  done
  for svc in grafana-grafana-grafana kibana ec-manager-webui-service qview-web; do
    pkill -f "kubectl port-forward.*$svc" 2>/dev/null || true
  done
}

case "${1:-}" in
  start)
    shift
    [[ $# -eq 0 ]] && set -- --all
    for flag in "$@"; do
      case "$flag" in
        --all)     _start qtrl; _start telem; _start sorting; _start holo
                   _kube -n grafana svc/grafana-grafana-grafana 3001:80
                   _kube -n kibana svc/kibana 5601:5601
                   _kube -n system-manager svc/ec-manager-webui-service 31003:31003
                   _kube -n qview-web svc/qview-web 8080:8080 ;;
        --qtrl)    _start qtrl ;;
        --telem)   _start telem ;;
        --sorting) _start sorting ;;
        --holo)    _start holo ;;
        --grafana) _kube -n grafana svc/grafana-grafana-grafana 3001:80 ;;
        --kibana)  _kube -n kibana svc/kibana 5601:5601 ;;
        --ec)      _kube -n system-manager svc/ec-manager-webui-service 31003:31003 ;;
        --qview)   _kube -n qview-web svc/qview-web 8080:8080 ;;
        *) echo "unknown flag: $flag" >&2; exit 1 ;;
      esac
    done ;;
  stop) _stop ;;
  *)
    echo "usage: tunnels start [--all|--qtrl|--telem|--sorting|--holo|--grafana|--kibana|--ec|--qview]" >&2
    echo "       tunnels stop" >&2
    exit 1 ;;
esac
