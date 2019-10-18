==============
 k8s 环境准备
==============

安装 docker
===========

卸载旧版本 ( 如果有的话 )
-------------------------

.. code-block:: shell

   $ yum remove docker docker-engine docker.io

:doc:`更新 docker 源<../source_change/docker-ce>`
-------------------------------------------------

安装 yum 的 https 支持包并添加 gpg 秘钥
---------------------------------------

这步原文说的是 apt

安装docker-ce
-------------

- 安装最新的稳定版

  .. code-block:: shell

     yum install -y docker-ce

- 安装指定版本

  .. code-block:: shell

     #获取版本列表
     $ apt-cache madison docker-ce

     #指定版本安装(比如版本是17.09.1~ce-0~ubuntu)
     $ apt-get install -y docker-ce=17.09.1~ce-0~ubuntu

- 接受所有ip的数据包转发

  .. code-block:: shell

     $ vi /lib/systemd/system/docker.service

     #找到ExecStart=xxx，在这行上面加入一行，内容如下：(k8s的网络需要)
     ExecStartPost=/sbin/iptables -I FORWARD -s 0.0.0.0/0 -j ACCEPT

- 启动服务

  .. code-block:: shell

     $ systemctl daemon-reload && systemctl restart docker
     
系统设置
========

所有节点都需要设置

关闭, 禁用防火墙
----------------

让所有机器之间都可以通过任意端口建立连接

.. code-block:: shell

   systemctl stop firewalld
   systemctl status firewalld

设置系统参数
------------

允许路由转发, 不对 bridge 的数据进行处理

.. code-block:: shell

   #写入配置文件
   $ cat <<EOF > /etc/sysctl.d/k8s.conf
   net.ipv4.ip_forward = 1
   net.bridge.bridge-nf-call-ip6tables = 1
   net.bridge.bridge-nf-call-iptables = 1
   EOF

   #生效配置文件
   $ sysctl -p /etc/sysctl.d/k8s.conf

配置 host 文件
--------------

.. code-block:: shell

   # 配置 host, 使每个 Node 都可以通过名字解析到 ip 地址
   $ vi /etc/hosts
   #加入如下片段( ip 地址和 servername 替换成自己的)
   192.168.1.101 server01
   192.168.1.102 server02
   192.168.1.103 server03

准备二进制文件
==============

kubernetes 的安装有几种方式, 不管是 kube-admin
还是社区贡献的部署方案都离不开这几种方式:

  - 使用现成的二进制文件

    ::

       直接从官方或其他第三方下载, 就是 kubernetes 各个组件的可执行文件.
       拿来就可以直接运行了. 不管是 centos, ubuntu 还是其他的 linux 发行版本,
       只要 gcc 编译环境没有太大的区别就可以直接运行的.
       使用较新的系统一般不会有什么跨平台的问题

  - 使用源码编译安装

    ::

       编译结果也是各个组件的二进制文件,
       所以如果能直接下载到需要的二进制文件基本没有什么编译的必要性;

  - 使用镜像的方式运行

    ::

       样一个功能使用二进制文件提供的服务, 也可以选择使用镜像的方式.
       就像 nginx, 像 mysql, 我们可以使用安装版, 搞一个可执行文件运行起来,
       也可以使用它们的镜像运行起来, 提供同样的服务.
       kubernetes 也是一样的道理, 二进制文件提供的服务镜像也一样可以提供;

  从上面的三种方式中其实使用镜像是比较优雅的方案, 容器的好处自然不用多说.
  但从初学者的角度来说容器的方案会显得有些复杂, 不那么纯粹,
  会有很多容器的配置文件以及关于类似二进制文件提供的服务如何在容器中提供的问题,
  容易跑偏.

