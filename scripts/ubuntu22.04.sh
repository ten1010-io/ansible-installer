bin_python_path=$root_path/bin/python/ubuntu2204
bin_pip_path=$root_path/bin/pip/ubuntu2204
bin_ansible_path=$root_path/bin/ansible/ubuntu2204

function get_python_version() {
  echo "3.10"
}

function from0() {
  function install_python() {
    dpkg -i $bin_python_path/from0/0/*.deb
    if [ $? -ne 0 ]; then
      echo "error: Fail to install Python3.10"
      exit 1
    fi
    dpkg -i $bin_python_path/from0/1/*.deb
    if [ $? -ne 0 ]; then
      echo "error: Fail to install Python3.10"
      exit 1
    fi
    dpkg -i $bin_python_path/from0/2/*.deb
    if [ $? -ne 0 ]; then
      echo "error: Fail to install Python3.10"
      exit 1
    fi
    dpkg -i $bin_python_path/from0/3/*.deb
    if [ $? -ne 0 ]; then
      echo "error: Fail to install Python3.10"
      exit 1
    fi
  }

  function uninstall_python() {
    export DEBIAN_FRONTEND=noninteractive
    apt remove --purge -y \
      libpython3-dev \
      libpython3-stdlib \
      libpython3.10-dev \
      libpython3.10-minimal \
      libpython3.10-stdlib \
      libpython3.10 \
      python3-dev \
      python3-distutils \
      python3-lib2to3 \
      python3-minimal \
      python3-pkg-resources \
      python3-wheel \
      python3.10-dev \
      python3.10-minimal \
      python3.10 \
      python3
    if [ $? -ne 0 ]; then
      echo "error: Fail to uninstall Python3.10"
      exit 1
    fi
  }

  function install_pip() {
    dpkg -i $bin_python_path/from0/0/*.deb
    dpkg -i $bin_python_path/from0/1/*.deb
    dpkg -i $bin_python_path/from0/2/*.deb
    dpkg -i $bin_python_path/from0/3/*.deb

    dpkg -i $bin_pip_path/from0/dependencies/0/*.deb
    dpkg -i $bin_pip_path/from0/dependencies/1/*.deb
    dpkg -i $bin_pip_path/from0/dependencies/2/*.deb
    dpkg -i $bin_pip_path/from0/*.deb
    if [ $? -ne 0 ]; then
      echo "error: Fail to install Pip3.10"
      exit 1
    fi
  }

  function uninstall_pip() {
    export DEBIAN_FRONTEND=noninteractive
    apt remove --purge -y \
      python3-pip \
      python3-setuptools
    if [ $? -ne 0 ]; then
      echo "error: Fail to uninstall Pip3.10"
      exit 1
    fi
  }

  function install_ansible() {
    pip3.10 install --no-index -f $bin_ansible_path ansible jmespath
    if [ $? -ne 0 ]; then
      echo "error: Fail to install Ansible"
      exit 1
    fi
  }

  function uninstall_ansible() {
    pip3.10 uninstall --yes \
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
  [ "$minor_version" = "2" ]; then
  from0
else
  echo "error: The only minor version from 0 to 2 of ubuntu22.04 is supported"
  exit 1
fi
