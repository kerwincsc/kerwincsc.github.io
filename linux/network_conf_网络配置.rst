==========
 网络配置
==========

网卡配置文件解析
================

.. code-block::

   DEVICE=name, name 是物理设备的名字
   IPADDR=addr, addr 是IP地址
   NETMASK=mask, mask 是网络掩码
   NETWORK=addr, addr 是网络地址
   BROADCAST=addr, addr 是广播地址
   GATEWAY=addr, addr 是网关地址. 
   ONBOOT=answer, 这里 answer 取下列值之一: 
       yes -- 该设备将在 boot 时被激活. 
       no -- 该设备不在 boot 时激活. 
   USERCTL=answer, 这里 answer 取下列值之一: 
       yes --非 root 用户可以控制该设备. 
       no -- 非 root 用户不允许控制该设备. 
   BOOTPROTO=proto, 这里 proto 取下列值之一: 
       none -- 不使用 boot 时协议
       bootp -- 使用 bootp 协议
       dhcp -- 使用 dhcp 协议
       static -- 使用静态地址
   
   以下是所有 PPP 和 SLIP 文件所使用的数值: 

   PERSIST=answer, 这里 answer 取下列值之一: 
       yes --该设备将一直维持激活态, 即便是 modem 被挂断而导致非激活态. 
       no -- 该设备不一直维持激活态. 
   MODEMPORT=port, 这里 port 是 modem 端口的设备名称 ( 如 /dev/modem ). 
   LINESPEED=baud, baud 是 modem 的线速率 ( 例如, "115200"). 
   DEFABORT=answer, 这里 answer 取下列值之一: 
       yes -- 在创建或编辑该接口的脚本时插入默认的终止字符串. 
       no -- 在创建或编辑该接口的脚本时不要插入默认的终止字符串.
   
   以下数值适用于所有的PPP文件: 

   DEFROUTE=answer, 这里 answer 取下列值之一: 
       yes -- 将该接口设置为默认路由. 
       no -- 不要将该接口设置为默认路由. 
   ESCAPECHARS=answer, 这里 answer 取下列值之一: 
       yes -- 使用预定义的 asyncmap. 
       no -- 不要使用预定义的 asyncmap. 
   ( 这里代表了一种简化的接口；它不让用户指定使用escape字符.
   然而, 几乎任何情况下都可以使用一个 00000000 的 asyncmap,
   而且如果需要的话, 可以通过设置 PPPOPTIONS 来使用任意的 asyncmap.)

   HARDFLOWCTL=answer, 这里 answer 取下列值之一: 
       yes -- 使用硬件流控制. 
       no -- 不使用硬件流控制. 
   PPPOPTIONS=options, 这里 options 是任意的选项字符串.
       它被放置在命令行的末尾, 以覆盖前面的选项 ( 如 asyncmap). 
   PAPNAME=name, 这里 name 是 pppd 命令行中 "name $PAPNAME" 的一部分.
   注意选项 "remotename" 总是指定为逻辑 ppp 设备名,
   如 "ppp0" ( 如果先前有其它ppp设备被激活的话, 这就可能是物理设备 ppp1)
   这样做便于管理 pap/chap 文件 --name/passwd 对与逻辑 ppp 设备名关联,
   因此它们可以被一起管理. 理论上说, 为逻辑 PPP 设备起除
   "ppp0"-- "pppN" 之外的如 "worldnet" 或 "myISP" 的名字是可行的. 

   REMIP=addr, 这里 addr 设置为远端的 ip 地址 ( 通常不加以指定 )
   MTU=value, 这里 value 是 MTU 的数值. 
   MRU=value, 这里 value 设置为 MRU 的值. 
   DISCONNECTTIMEOUT=value, 这里 value 表示当一个成功的连接被终止后
       要等多少秒后再进行连接. 
   RETRYTIMEOUT=value, 这里 value 指企图连接失败后要等多少秒之后以进行下一次连接

- centos 7

- centos 8

  centos8 后全面使用 NetworkManager 代替原有的 systemctl start network [#network]_,
  即 centos8 后, 在编辑好网卡配置文件后,
  使用 nmcli connection reload 进行网卡的配置的刷新


-------------

.. [#network] 在 centos7 中, 此命令实质上还是调用 /etc/rc.d/init.d/network
   这个 bash 脚本文件
