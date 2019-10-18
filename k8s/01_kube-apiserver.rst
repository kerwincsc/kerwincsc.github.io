==============================
 02 部署 APIServer ( 主节点 )
==============================

简介
====

kube-apiserver 是 Kubernetes 最重要的核心组件之一, 主要提供以下的功能:

  - 提供集群管理的 REST API 接口, 包括 **认证授权**, **数据校验** 以及 **集群状态变更** 等

  - 提供其他模块之间的数据交互和通信的枢纽 ( 其他模块通过 API Server 查询或修改数据,
    只有 API Server 才直接操作 etcd )

生产环境为了保证 apiserver 的高可用一般会部署 2+ 个节点, 在上层做一个 lb 做负载均衡,
比如 haproxy. 由于单节点和多节点在 apiserver 这一层说来没什么区别,
所以我们学习部署一个节点就足够.

部署 - 无认证
=============

APIServer 的部署方式也是通过系统服务. 部署流程跟 etcd 完全一样.

- 编写 service 文件

  .. code-block:: shell

     [Unit]
     Description=Kubernetes API Server
     Documentation=https://github.com/GoogleCloudPlatform/kubernetes
     After=network.target
     [Service]
     ExecStart={{BIN_PATH}}/kube-apiserver \
       --admission-control=NamespaceLifecycle,LimitRanger,DefaultStorageClass,ResourceQuota,NodeRestriction \
       --insecure-bind-address=0.0.0.0 \
       --kubelet-https=false \
       --service-cluster-ip-range=10.68.0.0/16 \
       --service-node-port-range=20000-40000 \
       --etcd-servers={{ETCD_ENDPOINTS}} \
       --enable-swagger-ui=true \
       --allow-privileged=true \
       --audit-log-maxage=30 \
       --audit-log-maxbackup=3 \
       --audit-log-maxsize=100 \
       --audit-log-path=/var/lib/audit.log \
       --event-ttl=1h \
       --v=2
     Restart=on-failure
     RestartSec=5
     Type=notify
     LimitNOFILE=65536
     [Install]
     WantedBy=multi-user.target

- 启动服务并加入开机自启

  .. code-block:: shell

     $ systemctl enable kube-apiserver.service
     $ service kube-apiserver start

- 查看服务日志, 是否有报错 ``$ journalctl -f -u kube-apiserver``

- :doc:`配置说明<kube-apiserver_配置说明>`
