LVS 部署
======================================================================

NAT 模式
------------------------------------------------------------

小于10台机器, 对公网 IP 需求小, LB是性能瓶颈;

- 负载均衡器 LB

.. code-block:: bash

   # 打开路由转发
   echo 1 > /proc/sys/net/ipv4/ip_forwards
   # 关闭 icmp 重定向, enp0s3 代表外网网卡, enp0s8 代表内网网卡
   echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects
   echo 0 > /proc/sys/net/ipv4/conf/default/send_redirects
   echo 0 > /proc/sys/net/ipv4/conf/enp0s3/send_redirects
   echo 0 > /proc/sys/net/ipv4/conf/enp0s8/send_redirects

.. code-block:: bash

   yum install -y ipvsadm
   ipvsadm -A -t lb_ip:port -s lb_algorithm
   # -m: masquerade : nat
   # -w: weight
   ipvsadm -a -t lb_ip:port -r rs_ip:port -m -w 2

- 真正的服务器 RS

  配置其网关为 LB 的内网网卡地址


DR 模式
------------------------------------------------------------

- 注意

  #. VIP 需要绑定在所有机器上
  #. 为了保证客户端的 arp 广播请求只被 LB 所响应, 必须更改 Real Server 的 arp 默认响应规则,
     就是修改内核参数 `arp_ignore`_

- LB

  只要将 VIP 配置到虚拟网卡上;

- RS

  #. 绑定虚拟网卡

     .. code-block:: bash
	
	# 如果之前 lo 上绑定了虚拟网卡且目前无效时, 加上注释的两行
	#ifdown lo
	#ifup lo
	ifconfig lo:0 $VIP broadcast $VIP netmask 255.255.255.255 up

  #. 修改内核参数

     .. code-block:: bash

	echo 1 > /proc/sys/net/ipv4/conf/lo/arp_ignore
	echo 2 > /proc/sys/net/ipv4/conf/lo/arp_announce
	echo 1 > /proc/sys/net/ipv4/conf/all/arp_ignore
	echo 2 > /proc/sys/net/ipv4/conf/all/arp_announce









.. _arp_ignore: https://www.imooc.com/article/79661

