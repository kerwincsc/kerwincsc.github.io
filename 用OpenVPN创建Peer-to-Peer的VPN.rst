============================================================
使用OpenVPN创建Peer-to-Peer的VPN
============================================================

运维场景
--------------------------------------------------

只需要把两台牌Internet上的服务器使用VPN互联起来的需求:

* 远程SNMP信息抓取

* 远程数据库备份等

物理架构
--------------------------------------------------

.. image:: vpn_p2p.svg

操作步骤
--------------------------------------------------

#. 在Host1和2上分别安装openvpn, openvpn在扩展库上 ``yum intall epel-release -y`` ;
   然后再 ``yum install openvpn -y`` ;

#. 在任意一台机器上生成静态密码, 并复制到另一台机器上:

   #. ``openvpn --genkey --secret <keyName>``

   #. ``scp <keyName> root@Host2_IP:/root/``

#. 创建隧道:

   #. Host1: ::

        openvpn --remote a.b.c.3 --dev tun0 --ifconfig 10.6.0.1 10.6.0.2 --secret <keyName> --daemon

   #. Host2: ::

        openvpn --remote x.y.z.2 --dev tun0 --ifconfig 10.6.0.2 10.6.0.1 --secret <keyName> --daemon

   其中关键配置解释如下:

   * --remote    指定peer-to-peer架构中, 对端的公网IP
   * --dev       指定使用tun设备
   * --ifconfig  指定虚拟隧道的本端和远端IP地址
   * --secret    指定包含静态密码的文件
   * --daemon    指定使用后台驻守进程的模式

   创建隧道步骤完成后, 两台服务器之间的虚拟专用网络如下所示:

   .. image:: vpn_p2p_tun0.svg
