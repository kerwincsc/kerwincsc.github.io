===============
 查看 mac 地址
===============

- 通用查询方法

  ``cat /sys/class/net/<net-card-name>/address``

  #. 进入目录 cd /sys/class/net
     
  #. ls 显示所有网卡文件夹, cd 进入要查看网卡的文件夹

  #. ``cat address`` 即可显示该网卡的 mac 地址

- ifconfig

  - Mac OS: ``ifconfig en0 | grep ether | awk '{print $2}'``

  - Linux:

- nmcli

  启动 NetworkManager 服务, 使用 nmcli 工具

  ``nmcli device show <ifname> | grep HWADDR``

-  查看连接到本机的远端 IP 的 MAC 地址

   不能看到本机的 MAC, 只能看到远程连接, 服务端用的比较多

   .. code-block:: bash

      [root@work]# cat /proc/net/arp
      IP address       HW type     Flags       HW address            Mask     Device
      192.168.222.1    0x1         0x2         0a:00:27:00:00:03     *        enp0s3
      172.31.225.1     0x1         0x2         00:76:86:54:d5:6e     *        enp0s8
      192.168.222.221  0x1         0x2         08:00:27:3b:7f:25     *        enp0s3
      10.0.4.2         0x1         0x2         52:54:00:12:35:02     *        enp0s9
      172.31.225.210   0x1         0x2         1c:1b:0d:24:66:ad     *        enp0s8*
