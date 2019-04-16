kubernetes部署
======================================================================

先决条件
------------------------------------------------------------
- 安装并启动 docker

  .. code-block:: shell

     yum install -y docker
     systemctl start docker
     systemctl enable docker

  - 出现 bridge-nf-call-iptables is disabled 告警时应该怎么办

    .. code-block:: shell

       vim /etc/sysctl.conf

       net.bridge.bridge-nf-call-ip6tables = 1
       net.bridge.bridge-nf-call-iptables = 1
       
       sysctl -p

- 添加 kubernetes 库

  - CentOS

    .. code-block:: shell

       cat <<EOF > /etc/yum.repos.d/kubernetes.repo
       [kubernetes]
       name=Kubernetes
       baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
       enabled=1
       gpgcheck=1
       repo_gpgcheck=1
       gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
       EOF


  - Ubuntu

    .. code-block:: shell

       apt-get update && apt-get install -y apt-transport-https
       curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
       cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
       deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
       EOF  

- 关闭 selinux

  .. code-block:: shell

     [root@kubeadm ~]# cat /etc/selinux/config 
     # This file controls the state of SELinux on the system. 
     # SELINUX= can take one of these three values: 
     #     enforcing - SELinux security policy is enforced. 
     #     permissive - SELinux prints warnings instead of enforcing. 
     #     disabled - No SELinux policy is loaded. 
     SELINUX=disabled 
     # SELINUXTYPE= can take one of three two values: 
     #     targeted - Targeted processes are protected, 
     #     minimum - Modification of targeted policy. Only selected processes are protected. 
     #     mls - Multi Level Security protection. 
     SELINUXTYPE=targeted 

     [root@kubeadm ~]# sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config
- 关闭 firewalld 或者打开指定端口

  .. code-block:: shell

     # 关闭 firewalld
     systemctl disable firewalld
     systemctl stop firewalld

     # 打开指定端口

- 关闭 SWAP

  .. code-block:: shell

     swapoff -a

kubernetes 部署
------------------------------------------------------------
- 安装 kubelet kubeadm kubectl

  .. code-block:: shell

     yum install -y kubelet kubeadm kubectl

  
- 编辑kubelet的启动环境变量

  该变量要与 docker 的 cgroup-driver 驱动一样

  .. code-block:: shell

     [root@kubeadm ~]# docker info | grep -i cgroup
     Cgroup Driver: systemd

     # 在 Kubenertes 1.14.0 中, 未发现此配置文件及配置项
     # 有一个相似的配置项, 在 /etc/sysconfig/kubelet 中
     # KUBELET_EXTRA_ARGS=
     [root@kubeadm ~]# cat /etc/default/kubelet
     KUBELET_KUBEADM_EXTRA_ARGS=--cgroup-driver=systemd

- 执行 kubeadm init

  初始化过程中, 要求:

    - docker kubelet 处于开机自启的状态
    - 关闭 selinux
    - 关闭 firewalld / 开启指定端口
    - 关闭 SWAP
