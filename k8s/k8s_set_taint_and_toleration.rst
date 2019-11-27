==================
 设置污点以及容忍
==================

设置污点
========

.. code-block:: shell

   kubectl taint node [node] key=value[effect]
   
其中 [effect] 可取值: [ NoSchedule | PreferNoSchedule | NoExecute ]

- NoSchedule: 一定不能被调度.
- PreferNoSchedule: 尽量不要调度.
- NoExecute: 不仅不会调度, 还会驱逐 Node 上已有的 Pod.

查看节点的污点
==============
.. code-block:: shell

   kubectl describe node/node_name |grep Taint

取消污点
========

- 去除指定 key 及其 effect:

  kubectl taint nodes node_name key:[effect]- #( 这里的 key 不用指定 value )

- 去除指定 key 所有的 effect:

  kubectl taint nodes node_name key-

