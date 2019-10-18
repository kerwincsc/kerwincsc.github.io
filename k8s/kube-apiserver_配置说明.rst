=========================
 kube-apiserver 配置说明
=========================

重点配置说明
============

.. code-block:: shell

   [Unit]
   Description=Kubernetes API Server
   ...
   [Service]
   #可执行文件的位置
   ExecStart=/home/michael/bin/kube-apiserver \
   #非安全端口(8080)绑定的监听地址 这里表示监听所有地址
   --insecure-bind-address=0.0.0.0 \
   #不使用https
   --kubelet-https=false \
   #kubernetes集群的虚拟ip的地址范围
   --service-cluster-ip-range=10.68.0.0/16 \
   #service的nodeport的端口范围限制
   --service-node-port-range=20000-40000 \
   #很多地方都需要和etcd打交道，也是唯一可以直接操作etcd的模块
   --etcd-servers=http://192.168.1.102:2379 \
   ...
