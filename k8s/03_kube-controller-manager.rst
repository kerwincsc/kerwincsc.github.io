======================================
 03 部署 ControllerManager ( 主节点 )
======================================

简介
====

**Controller Manager** 由 ``kube-controller-manager`` 和
``cloud-controller-manager`` 组成, 是 Kubernetes 的大脑,
它通过 apiserver 监控整个集群的状态, 并确保集群处于预期的工作状态.
kube-controller-manager 由一系列的控制器组成,
像 **Replication Controller 控制副本**, **Node Controller 节点控制**,
**Deployment Controller 管理 deployment** 等等.
cloud-controller-manager 在 Kubernetes 启用 Cloud Provider 的时候才需要,
用来配合云服务提供商的控制.

controller-manager, scheduler 和 apiserver 三者的功能紧密相关,
一般运行在同一个机器上, 我们可以把它们当做一个整体来看,
所以保证了 apiserver 的高可用即是保证了三个模块的高可用.
也可以同时启动多个 controller-manager 进程, 但只有一个会被选举为 leader 提供服务.

部署 - 无认证
=============

- ``$ systemctl cat kube-controller-manager.service``

  .. code-block:: shell

     [Unit]
     Description=Kubernetes Controller Manager
     Documentation=https://github.com/GoogleCloudPlatform/kubernetes
     [Service]
     ExecStart=/usr/local/bin/kube-controller-manager \
       --address=127.0.0.1 \
       --master=http://127.0.0.1:8080 \
       --allocate-node-cidrs=true \
       --service-cluster-ip-range=10.68.0.0/16 \
       --cluster-cidr=172.20.0.0/16 \
       --cluster-name=kubernetes-kerwin \
       --leader-elect=true \
       --cluster-signing-cert-file= \
       --cluster-signing-key-file= \
       --v=2
     Restart=on-failure
     RestartSec=5
     [Install]
     WantedBy=multi-user.target

- 启动并加入开机自启

  ``systemctl enable kube-controller-manager && systemctl start kube-controller-manager``

- 检查日志 ``journalctl -f -u kube-controller-manager``

- :doc:`配置说明<kube-controller-manager_配置说明>`
