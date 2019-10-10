=========================
 InnoDB 刷脏页的控制策略
=========================

- 要正确地告诉 InnoDB 其所在主机的 IO 能力

  这样 InnoDB 才能知道需要全力刷脏页的时候, 可以刷多快.

  要用到 ``innodb_io_capacity`` 这个参数, 它会告诉 InnoDB 你的磁盘能力.
  这个值建议设置成磁盘的 IOPS.
  磁盘的 IOPS 可以通过 fio 这个工具来测试.

  .. code-block:: shell

     # 示例
     fio -filename=$filename -direct=1 -iodepth 1 -thread -rw=randrw
         -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10
         -group_reporting -name=mytest 

  如果没有正确设置 **innodb_io_capacity**, 将会导致性能问题, 如:

  MySQL 的写入速度很慢, :ref:`tps<TPS>` 很低, 但是数据库主机的 IO 压力不大
