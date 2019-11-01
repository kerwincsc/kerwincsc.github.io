==========================
 k8s 搭建过程中的常见问题
==========================

- iptables-restore: invalid option

  具体报错为:

  .. code-block:: shell
		  
     proxier.go:1667] Failed to execute iptables-restore: exit status 1 (iptables-restore: invalid option -- '5'

  尝试按装低于当前系统版本自带的 iptables, 比如 **iptables-1.4.7-19.el6**,
  去 `rpmfind`_ 下载, 或者去官方网站, 但是可能要编译.

- bridge-nf-call-iptables: No such file or directory

  `参考地址K8S`_

  - 背景

    .. code-block:: shell

       sysctl: cannot stat /proc/sys/net/bridge/bridge-nf-call-iptables: No such file or directory
       sysctl: cannot stat /proc/sys/net/bridge/bridge-nf-call-ip6tables: No such file or directory
  
  - 操作流程

    .. code-block:: shell

       $ cat > kubernetes.conf <<EOF
       net.bridge.bridge-nf-call-iptables=1
       net.bridge.bridge-nf-call-ip6tables=1
       net.ipv4.ip_forward=1
       vm.swappiness=0
       vm.overcommit_memory=1
       vm.panic_on_oom=0
       EOF

  - 解决方式

    - 安装相关库

      .. code-block:: shell

	 $ sudo yum install -y epel-release
	 $ sudo yum install -y conntrack ipvsadm ipset jq sysstat curl iptables

    - 启动系统模块

      .. code-block:: shell

	 $ sudo modprobe br_netfilter
	 $ sudo modprobe ip_vs

.. _rpmfind: http://rpmfind.net/

.. _参考地址K8S: http://i.yungeio.com/articles/14
