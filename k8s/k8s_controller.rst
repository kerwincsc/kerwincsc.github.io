================
 k8s 控制器说明
================

Deployment
==========

适用场景:

- 一个应用的所有 Pod, 是完全一样的;

- 互相之间没有顺序

- 无所谓运行在哪台宿主机上

- 需要的时候, Deployment 就可以通过 Pod 模板创建新的 Pod;
  不需要的时候, Deployment 就可以 "杀掉" 任意一个 Pod;

StatefulSet
===========

于 Deployment 基础上, 扩展出对 **有状态应用** 的初步支持;

- 实例之间有不对等关系

- 实例对外部数据有依赖关系的应用

Headless Service
================

Headless Service, 其实仍是一个标准 Service 的 YAML 文件. 只不过,
**它的 clusterIP 字段的值是: None**, 即: 这个 Service, 没有一个 VIP 作为 " 头 ".
这也就是 Headless 的含义. 所以, 这个 Service 被创建后并不会被分配一个 VIP,
而是会以 DNS 记录的方式暴露出它所代理的 Pod.

DaemonSet
==========

有如下三个特征

#. 这个 Pod 运行在 Kubernetes 集群里的每一个节点 (Node) 上;
   
#. 每个节点上只有一个这样的 Pod 实例;

#. 当有新的节点加入 Kubernetes 集群后, 该 Pod 会自动地在新节点上被创建出来;
   而当旧节点被删除后, 它上面的 Pod 也相应地会被回收掉;

DaemonSet 的 " 过人之处 ", 其实就是依 靠Toleration 实现的;

在 DaemonSet 上, 我们一般都应该加上 resources 字段, 来限制它的 CPU 和内存使用,
防止它占用过多的宿主机资源
