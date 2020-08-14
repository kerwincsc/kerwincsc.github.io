===============
 查看 mac 地址
===============

- 通用查询方法

  #. 进入目录 cd /sys/class/net
     
  #. ls 显示所有网卡文件夹, cd 进入要查看网卡的文件夹

  #. ``cat address`` 即可显示该网卡的 mac 地址

- ifconfig

  - Mac OS: ``ifconfig en0 | grep ether | awk '{print $2}'``

  - Linux:
