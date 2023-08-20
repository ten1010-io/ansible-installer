#!/usr/bin/env bash
root_path="$( cd -- "$(dirname "$0")/.." >/dev/null 2>&1 ; pwd -P )"
scripts_path=$root_path/scripts

source $scripts_path/common.sh

function parse_options() {
  VALID_ARGS=$(getopt -o h --long python-only -- "$@")
  if [ $? -ne 0 ]; then
    echo "error: Fail to parse options"
    exit 1
  fi
  eval set -- "$VALID_ARGS"
  while [ : ]; do
    case "$1" in
    --python-only)
      python_only=true
      shift
      ;;
    -h)
      echo "usage: $(basename $0) [--python-only]"
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
ensure_bin_directory_exist

if [ "$(check_installed "$python_command")" = "false" ]; then
  install_python
else
  echo "info: Python$python_version already installed"
fi
if [ "$(check_installed "$pip_command")" = "false" ]; then
  install_pip
else
  echo "info: Pip$python_version already installed"
fi

if [ "$python_only" = "true" ]; then
  exit 0
fi

if [ "$(check_installed ansible)" = "false" ]; then
  install_ansible
else
  echo "info: Ansible already installed"
  exit 0
fi
