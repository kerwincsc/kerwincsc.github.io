==================================
 kube-controller-manager 配置说明
==================================

重点配置说明
============

.. code-block:: shell

   [Unit]
   Description=Kubernetes Controller Manager
   ...
   [Service]
   ExecStart=/home/michael/bin/kube-controller-manager \
     #对外服务的监听地址，这里表示只有本机的程序可以访问它
     --address=127.0.0.1 \
     #apiserver的url
     --master=http://127.0.0.1:8080 \
     #服务虚拟ip范围，同apiserver的配置
     --service-cluster-ip-range=10.68.0.0/16 \
     #pod的ip地址范围
     --cluster-cidr=172.20.0.0/16 \
     #下面两个表示不使用证书，用空值覆盖默认值
     --cluster-signing-cert-file= \
     --cluster-signing-key-file= \
     ...
								    
