============
 Kubernetes
============

安装 kubernetes 的时候, 需要安装 kubelet, kubeadm 等包,
但k8s官网给的yum源是 packages.cloud.google.com, 国内访问不了,
此时我们可以使用阿里云的 yum 仓库镜像

阿里云上没有附 Help 说明连接, 简单摸索了下, 如下设置可用 (centos).
注意不要开启 check

.. code-block:: shell

   cat <<EOF > /etc/yum.repos.d/kubernetes.repo
   [kubernetes]
   name=Kubernetes
   baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
   enabled=1
   gpgcheck=0
   repo_gpgcheck=0
   gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
           http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
   EOF

如果你用的是 ubuntu, 也可以试试 ustc 的 mirror, 更新比较及时

.. code-block:: shell

   cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
   deb http://mirrors.ustc.edu.cn/kubernetes/apt kubernetes-xenial main
   EOF

   
.. toctree::
   :maxdepth: 2

   docker_io.rst
   k8s_gcr_io.rst
   gcr_io.rst
   quay_io.rst
