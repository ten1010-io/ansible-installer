function get_os_information() {
  distribution=$(grep -oP "^ID=\"?\K\w+(?=\"?$)" /etc/os-release)
  if [ $? -ne 0 ]; then
    echo "error: Fail to get os information"
    exit 1
  fi
  local version_id=$(grep -oP "^VERSION_ID=\"?\K[0-9.]+(?=\"?$)" /etc/os-release)
  if [ $? -ne 0 ]; then
    echo "error: Fail to get os information"
    exit 1
  fi
  local version=$(grep -oP "^VERSION=\"?\K[0-9.a-zA-Z \(\)]+(?=\"?$)" /etc/os-release)
  if [ $? -ne 0 ]; then
    echo "error: Fail to get os information"
    exit 1
  fi
  if [ "$distribution" = "ubuntu" ]; then
    major_version=$version_id
    minor_version=$(echo "$version" | grep -oP "$major_version.\K[0-9]+")
    if [ -z $minor_version ]; then
      minor_version="0"
    fi
  elif [ "$distribution" = "rhel" ]; then
    major_version=$(echo "$version_id" | grep -oP "^[0-9]+(?=.[0-9]+$)")
    if [ $? -ne 0 ]; then
      echo "error: Fail to get os information"
      exit 1
    fi
    minor_version=$(echo "$version_id" | grep -oP "^[0-9]+.\K[0-9]+$")
    if [ $? -ne 0 ]; then
      echo "error: Fail to get os information"
      exit 1
    fi
  elif [ "$distribution" = "centos" ]; then
    local name=$(grep -oP "^NAME=\"?\K[0-9.a-zA-Z \(\)]+(?=\"?$)" /etc/os-release)
    local stream=$(echo $name | grep -oP "Stream")
    if [ -n "$stream" ]; then
      echo "error: CentOS Stream is not supported"
      exit 1
    fi
    local version_id=$(grep -oP "CentOS Linux release \K[0-9.]+" /etc/centos-release)
    major_version=$(echo "$version_id" | grep -oP "^[0-9]+(?=.[0-9.]+$)")
    if [ $? -ne 0 ]; then
      echo "error: Fail to get os information"
      exit 1
    fi
    minor_version=$(echo "$version_id" | grep -oP "^[0-9]+.\K[0-9]+(?=.[0-9]+$)")
    if [ $? -ne 0 ]; then
      echo "error: Fail to get os information"
      exit 1
    fi
  else
    echo "error: Fail to get os information. the only distribution out of [ubuntu, rhel, centos] supported"
    exit 1
  fi
}

function import_os_dependent_functions() {
  if [ "$distribution" = "ubuntu" ] && [ "$major_version" = "22.04" ]; then
    source $scripts_path/ubuntu22.04.sh
  elif [ "$distribution" = "rhel" ] && [ "$major_version" = "8" ]; then
    source $scripts_path/rhel8.sh
  elif [ "$distribution" = "centos" ] && [ "$major_version" = "8" ]; then
    source $scripts_path/centos8.sh
  else
    echo "error: The only os out of [ubuntu22.04, rhel8, centos8] supported"
    exit 1
  fi
}
