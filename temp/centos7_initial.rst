Centos7 安装后初始化
======================================================================

- 关闭 selinux

  .. code-block:: shell

     sed -i 's/SELINUX.*ing/SELINUX=disabled/'  /etc/selinux/config
     reboot


- 关闭 NetworkManager

  .. code-block:: shell

     systemctl stop NetworkManager
     systemctl disable NetworkManager
