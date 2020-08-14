==============
 查看网卡UUID
==============

- 利用 nmcli 命令获取 NetworkManager 服务提供的信息

  centos7, centos8 已默认安装此服务及相应工具

  ``nmcli connection | grep '<nic_name>' | awk '{print $2}'``

  ``nmcli c | grep '<nic_name>' | awk '{print $2}'`` c for connection

- uuidgen

  如果在配置网卡文件时, 没有 nmcli 命令,
  可以手动生成 UUID, 并将其填入相应字段, 以作唯一标识
