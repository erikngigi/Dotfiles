#!/usr/bin/env bash

# Manage and check status of a user service
usctl() {
  local cmd="${1:-restart}"
  local service="$2"

  if [[ -z "$service" ]]; then
    echo "Usage: usctl [enable|disable|restart|start|stop|status] <service>"
    return 1
  fi

  case "$cmd" in
    enable | disable | restart | start | stop)
      systemctl --user "$cmd" "$service" && systemctl --user status "$service"
      ;;
    status)
      systemctl --user status "$service"
      ;;
    *)
      echo "Unknown command $cmd"
      echo "Usage: usctl [enable|disable|restart|start|stop|status] <service>"
      return 1
      ;;
  esac
}

# Manage and check status of a user service
ssctl() {
  local cmd="${1:-restart}"
  local service="$2"

  if [[ -z "$service" ]]; then
    echo "Usage: ssctl [enable|disable|restart|start|stop|status] <service>"
    return 1
  fi

  case "$cmd" in
    enable | disable | restart | start | stop)
      sudo systemctl "$cmd" "$service" && systemctl status "$service"
      ;;
    status)
      sudo systemctl status "$service"
      ;;
    *)
      echo "Unknown command $cmd"
      echo "Usage: ssctl [restart|start|stop|status] <service>"
      return 1
      ;;
  esac
}
