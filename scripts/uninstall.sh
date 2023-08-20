#!/usr/bin/env bash
root_path="$( cd -- "$(dirname "$0")/.." >/dev/null 2>&1 ; pwd -P )"
scripts_path=$root_path/scripts

source $scripts_path/common.sh

function parse_options() {
  VALID_ARGS=$(getopt -o h --long ansible-only -- "$@")
  if [ $? -ne 0 ]; then
    echo "error: Fail to parse options"
    exit 1
  fi
  eval set -- "$VALID_ARGS"
  while [ : ]; do
    case "$1" in
    --ansible-only)
      ansible_only=true
      shift
      ;;
    -h)
      echo "usage: $(basename $0) [--ansible-only]"
      exit 1
      ;;
    --)
      shift
      break
      ;;
    esac
  done
}

parse_options "$@"

if [ "$(check_installed ansible)" = "true" ]; then
  uninstall_ansible
else
  echo "info: Ansible already uninstalled"
fi

if [ "$ansible_only" = "true" ]; then
  exit 0
fi

if [ "$(check_installed $pip_command)" = "true" ]; then
  uninstall_pip
else
  echo "info: Pip$python_version already uninstalled"
fi
if [ "$(check_installed $python_command)" = "true" ]; then
  uninstall_python
else
  echo "info: Python$python_version already uninstalled"
fi
