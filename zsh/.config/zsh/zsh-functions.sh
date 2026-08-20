#!/usr/bin/env bash

# Manage and check status of a user service
usctl() {
  local cmd="${1:-restart}"
  local service="$2"

  # Handle daemon-reload separately as it doesn't accept a service argument
  if [[ "$cmd" == "daemon-reload" ]]; then
    systemctl --user daemon-reload
    return $?
  fi

  if [[ -z "$service" ]]; then
    echo "Usage: usctl [enable|daemon-reload|disable|restart|start|stop|status] <service>"
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
      echo "Usage: usctl [enable|daemon-reload|disable|restart|start|stop|status] <service>"
      return 1
      ;;
  esac
}

# Manage and check status of a user service
ssctl() {
  local cmd="${1:-restart}"
  local service="$2"

  # Handle daemon-reload separately as it doesn't accept a service argument
  if [[ "$cmd" == "daemon-reload" ]]; then
    sudo systemctl --user daemon-reload
    return $?
  fi

  # Validate service name for all other commands
  if [[ -z "$service" ]]; then
    echo "Usage: ssctl [enable|daemon-reload|disable|restart|start|stop|status] <service>"
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
      echo "Usage: ssctl [enable|daemon-reload|disable|restart|start|stop|status] <service>"
      return 1
      ;;
  esac
}
