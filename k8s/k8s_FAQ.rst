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

- 1 node(s) had taints that the pod didn't tolerate
  
  默认 k8s 不允许往 master 节点装东西, 强行设置允许:

  ``kubectl taint nodes --all node-role.kubernetes.io/master-``

- kubeadm join 192.168.11.70:6443 --token 01b3mt.qzadkfad3edi89up8nam4 报错

  加入这个参数

  --discovery-token-ca-cert-hash sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855

  shaXXXX 这个字符串是表示 master 上的 ca 证书的 hash 值

  获取 master 上 ca 证书的 hash 值

  .. code-block:: shell

     openssl x509 -in /etc/kubernetes/pki/ca.crt -noout -pubkey | openssl rsa -pubin -outform DER 2>/dev/null | sha256sum | cut -d' ' -f1

.. _rpmfind: http://rpmfind.net/

.. _参考地址K8S: http://i.yungeio.com/articles/14
