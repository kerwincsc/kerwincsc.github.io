==============================
 k8s 设置 node 节点 Role 属性
==============================

`参考`_

.. code-block:: shell
   :linenos:

   root@k8s-master:~# kubectl get nodes
   NAME         STATUS     ROLES     AGE       VERSION
   k8s-master   Ready      master    50d       v1.11.2
   k8s-node1    NotReady   <none>    50d       v1.11.2
   k8s-node2    NotReady   <none>    50d       v1.11.2

在 kubeadm 引导的 k8s 集群中, 查看 nodes 信息时, ROLES 一列标记了 master 节点的身份,
其他节点默认没有标记. 在手动安装的 k8s 集群中, 你看到情况可能是如下这样的

.. code-block:: shell
   :linenos:

   root@k8s-master:~# kubectl get nodes
   NAME         STATUS     ROLES     AGE       VERSION
   k8s-master   Ready      <none>    50d       v1.11.2
   k8s-node1    NotReady   <none>    50d       v1.11.2
   k8s-node2    NotReady   <none>    50d       v1.11.2
   
没错, 连 master 节点的标记都没有, 我们可以手动给任意 node 设置 ROLES;

原理就是 **给 node 打标签**, 只不过是特殊的标签;

.. code-block:: shell
   :linenos:

   root@k8s-master:~# kubectl get nodes
   NAME         STATUS     ROLES     AGE       VERSION
   k8s-master   Ready      master    50d       v1.11.2
   k8s-node1    NotReady   <none>    50d       v1.11.2
   k8s-node2    NotReady   <none>    50d       v1.11.2
   # 以下这句后半部看不明白, 待了解
   root@k8s-master:~# kubectl label node k8s-node1 node-role.kubernetes.io/worker=worker
   node/k8s-node1 labeled
   root@k8s-master:~# kubectl get nodes
   NAME         STATUS     ROLES     AGE       VERSION
   k8s-master   Ready      master    50d       v1.11.2
   k8s-node1    NotReady   worker    50d       v1.11.2
   k8s-node2    NotReady   <none>    50d       v1.11.2
   root@k8s-master:~#
		


.. _参考: https://docs.lvrui.io/2018/11/01/k8s%E8%AE%BE%E7%BD%AEnode%E8%8A%82%E7%82%B9Role%E5%B1%9E%E6%80%A7/

