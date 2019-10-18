=========================
 kube-scheduler 配置说明
=========================

重点配置说明
============

.. code-block:: shell

   [Unit]
   Description=Kubernetes Scheduler
   ...
   [Service]
   ExecStart=/home/michael/bin/kube-scheduler \
   #对外服务的监听地址，这里表示只有本机的程序可以访问它
   --address=127.0.0.1 \
   #apiserver的url
   --master=http://127.0.0.1:8080 \
   ...
