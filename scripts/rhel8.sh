bin_python_path=$root_path/bin/python/rhel8
bin_pip_path=$root_path/bin/pip/rhel8
bin_ansible_path=$root_path/bin/ansible/rhel8

function get_python_version() {
  echo "3.11"
}

function from0() {
  function install_python() {
    rpm -Uvh --oldpackage --replacepkgs $bin_python_path/from0/dependencies/*.rpm
    rpm -Uvh $bin_python_path/from0/*.rpm
    if [ $? -ne 0 ]; then
      echo "error: Fail to install Python3.11"
      exit 1
    fi
  }

  function uninstall_python() {
    yum -y erase \
      python3.11 \
      mpdecimal \
      python3.11-libs \
      python3.11-pip-wheel \
      python3.11-setuptools-wheel \
      python3.11-pip \
      python3.11-setuptools
    if [ $? -ne 0 ]; then
      echo "error: Fail to uninstall Python3.11"
      exit 1
    fi
  }

  function install_pip() {
    rpm -Uvh $bin_pip_path/from0/*.rpm
    if [ $? -ne 0 ]; then
      echo "error: Fail to install Pip3.11"
      exit 1
    fi
  }

  function uninstall_pip() {
    yum -y erase \
      python3.11-pip \
      python3.11-setuptools
    if [ $? -ne 0 ]; then
      echo "error: Fail to uninstall Pip3.11"
      exit 1
    fi
  }

  function install_ansible() {
    pip3.11 install --no-index -f $bin_ansible_path ansible jmespath
    if [ $? -ne 0 ]; then
      echo "error: Fail to install Ansible"
      exit 1
    fi
  }

  function uninstall_ansible() {
    pip3.11 uninstall --yes \
      ansible \
      ansible-core \
      Jinja2 \
      PyYAML \
      MarkupSafe \
      resolvelib \
      cffi \
      packaging \
      cryptography \
      pycparser \
      jmespath
    if [ $? -ne 0 ]; then
      echo "error: Fail to uninstall Ansible"
      exit 1
    fi
    rm -rf ~/.ansible
  }
}

if [ "$minor_version" = "0" ] ||
  [ "$minor_version" = "1" ] ||
  [ "$minor_version" = "2" ] ||
  [ "$minor_version" = "3" ] ||
  [ "$minor_version" = "4" ] ||
  [ "$minor_version" = "5" ] ||
  [ "$minor_version" = "6" ] ||
  [ "$minor_version" = "7" ]; then
  from0
else
  echo "error: The only minor version from 0 to 7 of rhel8 is supported"
  exit 1
fi
