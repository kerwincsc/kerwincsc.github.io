为什么 netstat 对某些服务只显示了 tcp6 监听端口
======================================================================

部署 jenkins 时, 发现一个奇怪的现象, netstat 查看监听的服务端口时,
却只显示了 tcp6 的监控, 但是服务明明是可以通过 tcp4 的 ipv4 地址访问的,
那为什么没有显示 tcp4 的监听呢?

以 sshd 监听的 22 端口为例:

.. code-block:: shell

   # netstat -tlnp | grep :22
   tcp      0    0 0.0.0.0:22    0.0.0.0:*       LISTEN      1444/sshd
   tcp6     0    0 :::22         :::*            LISTEN      1444/sshd

可以看到, netstat 显示表示 sshd 既监听在 ipv4 的地址, 又监听在 ipv6 的地址;

而 jenkins 监听 8080 端口时:

.. code-block:: shell

   # netstat -lnpt
   Active Internet connections (only servers)
   Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
   tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      643/sshd            
   tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      782/master          
   tcp6       0      0 172.31.225.71:8080      :::*                    LISTEN      13150/java          
   tcp6       0      0 :::22                   :::*                    LISTEN      643/sshd            
   tcp6       0      0 ::1:25                  :::*                    LISTEN      782/master

却发现只显示了监听在 ipv6 的地址上, 但是, 通过 ipv4 的地址明明是可以访问访问的;

下面来看下怎样解释这个现象;

首先，关闭 ipv6 并且重启 jenkins:

.. code-block:: shell

   # sysctl net.ipv6.conf.all.disable_ipv6=1
   # systemctl restart jenkins

现在, 看下 jenkins 监听的地址:

.. code-block:: shell

   # netstat -lnpt
   Active Internet connections (only servers)
   Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
   tcp        0      0 172.31.225.71:8080      0.0.0.0:*               LISTEN      13317/java          
   tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      643/sshd            
   tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      782/master          
   tcp6       0      0 :::22                   :::*                    LISTEN      643/sshd            
   tcp6       0      0 ::1:25                  :::*                    LISTEN      782/master

可以看到，已经只监听 ipv4 地址了;

那为什么在 ipv6 开启的时候, netstat 只显示了 tcp6 的监听而非像 sshd 那样既显示 tcp 又显示 tcp6 的监听呢?

参考 `Chengwei's world`_ 

情况应该类似, ipv6 实际上可以处理 ipv4 的请求的, 当与 V6ONLY 相似的功能没有开启的时候, 反之不然;


.. _Chengwei's world: http://www.chengweiyang.cn/2017/03/05/why-netstat-not-showup-tcp4-socket/
