#!/usr/bin/env bash
root_path="$( cd -- "$(dirname "$0")/.." >/dev/null 2>&1 ; pwd -P )"
scripts_path=$root_path/scripts

$scripts_path/uninstall.sh "$@"
