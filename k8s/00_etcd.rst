=========================
 01 部署 ETCD ( 主节点 )
=========================

简介
====

kubernetes 需要存储很多东西, 像它本身的节点信息, 组件信息,
还有通过 kubernetes 运行的 pod, deployment, service 等等, 都需要持久化.
etcd 就是它的数据中心. 生产环境中为了保证数据中心的高可用和数据的一致性,
一般会部署最少三个节点.

如果你的环境已经有了 etcd 服务 ( 不管是单点还是集群 ), 可以忽略这一步.
前提是你在生成配置的时候填写了自己的 **etcd endpoint**.

简易部署
========

#. 准备好 etcd 的二进制文件和服务的配置, 把它做成系统服务并启动.

   二进制文件去 github 下载, 服务配置如下

   .. code-block:: shell

      $ systemctl cat etcd.service
   
      [Unit]
      Description=Etcd Server
      After=network.target
      After=network-online.target
      Wants=network-online.target
      Documentation=https://github.com/coreos

      [Service]
      Type=notify
      WorkingDirectory=/var/lib/etcd/
      ExecStart=/usr/local/bin/etcd \
        --name={{NODE_IP}} \
	--listen-client-urls=http://{{NODE_IP}}:2379,http://127.0.0.1:2379 \
	--advertise-client-urls=http://{{NODE_IP}}:2379 \
	--data-dir=/var/lib/etcd
      Restart=on-failure
      RestartSec=5
      LimitNOFILE=65536
   
      [Install]
      WantedBy=multi-user.target

:doc:`配置说明<etcd_配置说明>`


FAQ
===

- 待解决 **serving insecure client requests on 127.0.0.1:2379, this is strongly discouraged!**
