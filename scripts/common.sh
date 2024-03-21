function ensure_bin_directory_exist() {
  if [ ! -e $root_path/bin ]; then
    echo "error: Directory \"bin\" does not exist. please execute \"download-bin.sh\" first"
    exit 1
  fi
  if [ ! -d $root_path/bin ]; then
    echo "error: File of which name is \"bin\" is not directory. please delete the file and execute \"download-bin.sh\""
    exit 1
  fi
}

function check_installed() {
  which "$1" 1>/dev/null 2>/dev/null
  if [ $? -eq 0 ]; then
    echo "true"
    exit
  fi
  echo "false"
}
