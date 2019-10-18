===========================
 部署 Scheduler ( 主节点 )
===========================

简介
===

kube-scheduler 负责分配调度 Pod 到集群内的节点上, 它监听 kube-apiserver,
查询还未分配 Node 的 Pod, 然后根据调度策略为这些 Pod 分配节点.
前面讲到的kubernetes的各种调度策略就是它实现的.

部署
===

- ``systemctl cat kube-scheduler``

  .. code-block:: shell

     [Unit]
     Description=Kubernetes Scheduler
     Documentation=https://github.com/GoogleCloudPlatform/kubernetes

     [Service]
     ExecStart=/usr/local/bin/kube-scheduler \
       --address=127.0.0.1 \
       --master=http://127.0.0.1:8080 \
       --leader-elect=true \
       --v=2
     Restart=on-failure
     RestartSec=5
     [Install]
     WantedBy=multi-user.target

- 启动并加入自启

  ``systemctl enable kube-scheduler && systemctl start kube-scheduler``

- 查看日志 ``journalctl -f -u kube-scheduler``


- :doc:`配置说明<kube-scheduler_配置说明.rst>`
