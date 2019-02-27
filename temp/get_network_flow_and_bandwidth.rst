如何从Linux系统中获取带宽, 流量网络数据
======================================================================

Linux中的网络数据提取
------------------------------------------------------------

在Linux系统中我们可以从 /proc 目录里来获取相应的数据并进行处理.

让我们来看下网络相关的 /proc/net/dev

.. code-block::

   Inter-|   Receive                                                |  Transmit
   face  |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed                                                                                                                 enp0s3:40672303  428889    0    0    0     0          0        71  8611377   25983    0    0    0     0       0          0                                                                                                                 enp0s9:       0       0    0    0    0     0          0         0  8404374   47201    0    0    0     0       0          0                                                                                                                     lo: 2944080     941    0    0    0     0          0         0  2944080     941    0    0    0     0       0          0         

这个文件是本机所有网卡的数据记录.

从标题可以看出, 第一列是网卡名称, 第二列是入方向字节数(流量), 第三列是入方向数据包数量,
第四列是入方向错误包数, 第10列是出方向字节数(流量).

脚本计算带宽和流量
------------------------------------------------------------

有了数据, 我们就可以写个shell脚本来获取带宽和流量数据了

脚本 getnettraffic.sh

.. code-block:: bash

   #!/bin/bash

   DATE1=`date --utc`
   RX1=`cat /proc/net/dev | grep enp0s3 |awk '{print $2}'`
   TX1=`cat /proc/net/dev | grep enp0s3 |awk '{print $10}'`

   sleep 60

   DATE2=`date --utc`
   RX2=`cat /proc/net/dev | grep enp0s3 |awk '{print $2}'`
   TX2=`cat /proc/net/dev | grep enp0s3 |awk '{print $10}'`
   RX=$(( $RX2-$RX1 ))
   TX=$(( $TX2-$TX1 ))
   #RX=`expr $RX2 - $RX1`
   #TX=`expr $TX2 - $TX1`
   RXBAND=$(($RX*8/60/1024/1024))
   TXBAND=$(($TX*8/60/1024/1024))
   #RXBAND=`expr $RX \* 8 \/ 60 \/ 1024 \/ 1024`
   #TXBAND=`expr $TX \* 8 \/ 60 \/ 1024 \/ 1024`

   echo "time Range $DATE1 - $DATE2"
   echo "Network In Bytes: $RX Bytes"
   echo "Network Out Bytes: $TX Bytes"
   echo "Network In BW: $RXBAND Mbps"
   echo "Network Out BW: $TXBAND Mbps"

扩展
------------------------------------------------------------

我们已经知道 /proc/net/dev 这个文件存储了主机上的网络数据,
但如果我想看某个进程的网络数据怎么办?

同样的Linux也提供了 **/proc/$PID/net/dev** 这个文件来记录进程的网络数据;

如果主机上运行了虚拟机或者docker容器, 也可以使用这种方法来获取网络数据;
