===============
 iptables 说明
===============

防火墙策略规则是按照 **从上到下** 的顺序匹配的,
因此一定要把 **允许动作放到拒绝动作前面**, 否则所有的流量就将被拒绝掉,
从而导致任何主机都无法访问我们的服务;

注意, 使用iptables命令配置的防火墙规则默认会在系统下一次重启时失效,
如果想让配置的防火墙策略永久生效, 还要执行保存命令 ``service iptables save``

iptables 常用参数
=================

+-------------+----------------------------------------------------------+
| 参数        | 作用                                                     |
+=============+==========================================================+
| -P          | 设置默认策略                                             |
+-------------+----------------------------------------------------------+
| -F          | 清空规则链                                               |
+-------------+----------------------------------------------------------+
| -L          | 查看规则链                                               |
+-------------+----------------------------------------------------------+
| -A          | 在规则链的末尾加入新规则                                 |
+-------------+----------------------------------------------------------+
| -I num      | 在规则链的头部加入新规则                                 |
+-------------+----------------------------------------------------------+
| -D          | 删除某一条规则                                           |
+-------------+----------------------------------------------------------+
| -s          | 匹配来源地址 IP / MASK, 加感叹号 ! 表示除这个 IP 外      |
+-------------+----------------------------------------------------------+
| -d          | 匹配目标地址                                             |
+-------------+----------------------------------------------------------+
| -i 网卡名称 | 匹配从这块网卡流入的数据                                 |
+-------------+----------------------------------------------------------+
| -o 网卡名称 | 匹配从这块网卡流出的数据                                 |
+-------------+----------------------------------------------------------+
| -p          | 匹配协议, 如 TCP, UDP, ICMP                              |
+-------------+----------------------------------------------------------+
| --dport num | 匹配目标端口号                                           |
+-------------+----------------------------------------------------------+
| --sport num | 匹配来源端口号                                           |
+-------------+----------------------------------------------------------+

iptables 操作
=============

- 查看已有的防火墙规则 iptables -L

- 清空规则 iptables -F

- 把 INPUT 链的默认策略设置为拒绝 ``iptables -P INPUT DROP``

-

iptables 典型用法
=================

- 允许 ping 命令检测是否在线

  即, 向 INPUT 链中添加允许 ICMP 流量进入的策略规则

  .. code-block:: shell

     iptables -I INPUT -p icmp -j ACCEPT

  禁 ping, 反向操作即可, ``iptables -D INPUT 1``

- 只允许指定网段主机访问本机 22 端口

  .. code-block:: shell

     iptables -I INPUT -s 192.168.10.0/24 -p tcp --dport 22 -j ACCEPT

- 拒绝访问本机指定端口

  .. code-block:: shell

     iptables -I INPUT -p tcp -dport port_num -j REJECT

- 拒绝指定主机访问本机指定端口

  如, 拒绝 192.168.10.5 访问 80 端口

  .. code-block:: shell

     iptables -I INPUT -p tcp -s 192.168.10.5 -dport 80 -j REJECT

- 拒绝所有主机访问指定端口范围

  .. code-block:: shell

     iptables -A INPUT -p tcp --dport 1000:1024 -j REJECT
     iptables -A INPUT -p udp --dport 1000:1024 -j REJECT
