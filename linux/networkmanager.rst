============================
 NetworkManger 网络管理工具
============================

NetworkManager 操作的对应的 ifcfg-eth0 网卡文件,
故修改后要重启网络以生效 ``systemctl restart network``

- **connection.autoconnect** 控制的是网卡配置文件的 **ONBOOT** 属性

  - yes ``nmcli connection modify <eth0> connection.autoconnect yes``

  - no ``nmcli connection modify <eth0> connection.autoconnect no``

- **ipv4.method** 控制 **BOOTPROTO**

  eth0 为网卡名

  - auto ``nmcli connection modify <eth0> ipv4.method auto``

  - manual ``nmcli connection modify <eth0> ipv4.method manual ipv4.address <ip_address>``

    将 ipv4.method 的属性修改为 manual 时, 要同时指定 ip 地址, 不然会报错;

配置 DNS
========

modify [--temporary] [id | uuid | path] <ID> ([+|-]<setting>.<property> <value>)+

持久 [ 或临时 ] 修改指定 id | uuid | path, 增 ( 减 ) 一条 ( 或多条) 的属性

- dns 替换 ``nmcli connection modify eth0 ipv4.dns '218.2.135.1'``

- 增加 DNS 记录 ``nmcli connection modify eth0 +ipv4.dns '61.147.37.1'``

- 减少 DNS 记录 ``nmcli connection modify eth0 -ipv4.dns '61.147.37.1'``
