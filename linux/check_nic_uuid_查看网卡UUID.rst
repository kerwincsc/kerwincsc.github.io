==============
 查看网卡UUID
==============

- 利用 nmcli 命令获取 NetworkManager 服务提供的信息

  centos7, centos8 已默认安装此服务及相应工具

  ``nmcli connection | grep '<nic_name>' | awk '{print $2}'``

  ``nmcli c | grep '<nic_name>' | awk '{print $2}'`` c for connection
