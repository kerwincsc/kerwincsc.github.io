=========================
 InnoDB 刷脏页的控制策略
=========================

- 要正确地告诉 InnoDB 其所在主机的 IO 能力

  这样 InnoDB 才能知道需要全力刷脏页的时候, 可以刷多快.

  要用到 ``innodb_io_capacity`` 这个参数, 它会告诉 InnoDB 你的磁盘能力.
  这个值建议设置成磁盘的 IOPS.
  磁盘的 IOPS 可以通过 **fio** 这个工具来测试.

  .. code-block:: shell

     # 示例
     fio -filename=$filename -direct=1 -iodepth 1 -thread -rw=randrw
         -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10
         -group_reporting -name=mytest 

  如果没有正确设置 **innodb_io_capacity**, 将会导致性能问题, 如:

  MySQL 的写入速度很慢, :ref:`tps<TPS>` 很低, 但是数据库主机的 IO 压力不大

  比如磁盘用的是 SSD, 但是 innodb_io_capocity 的值设置的比较低, 比如 300.
  于是, InnoDB 认为这个系统的能力就这么差,
  所以 **脏页刷特别慢, 甚至比脏页生成的速度还慢**,
  这样就造成了 **脏页累积**, 影响了查询和更新性能.

- 参考哪些因素来设计策略控制刷脏页的速度

  如果刷太慢, 将会有过多的内存脏页存在, redo log 将会写满;

  所以, InnoDB 的刷盘速度就要参考这两个因素: 一是 **脏页比例**,
  二是 **redo log 写盘速度**

  InnoDB 会根据这两个因素先单独算出两个数字.

  参数 ``innodb_max_dirty_pages_pct`` 是脏页比例上限, 默认值是 75%.
  InnoDB 会根据当前的脏页比例 ( 假设为 M ),
  算出一个范围在 0 到 100 之间的数字, 计算这个数字的伪代码类似这样:

  .. code-block:: shell

     F1(M)
     {
        if M>=innodb_max_dirty_pages_pct then
	  return 100;
	return 100*M/innodb_max_dirty_pages_pct;
     }
     
  InnoDB 每次 **写入的日志都有一个序号**,
  当前写入的序号跟 checkpoint 对应的序号之间的差值, 假设为N.
  InnoDB 会根据这个 N 算出一个范围在 0 到 100 之间的数字,
  这个计算公式可以记为 F2(N). F2(N) 算法比较复杂,
  只要知道 N 越大, 算出来的值越大就好了.

  然后, 根据上述算得的 F1(M) 和 F2(N) 两个值, **取其中较大的值** 记为 R,
  之后引擎就可以按照 innodb_io_capacity 定义的能力乘以 R% 来控制刷脏页的速度.
  如图所示:

  .. image:: innodb_flush_dirty_policy.png
     :alt: InnoDB 刷脏页速度策略

为什么 MySQL 会抖一下
=====================

InnoDB 会在后台刷脏页, 而刷脏页的过程是要将内存页写入磁盘.
所以, 无论是查询语句在需要内存的时候可能要求淘汰一个脏页,
还是由于刷脏页的逻辑会占用 IO 资源并可能影响到更新语句,
都可能从业务端感知到 MySQL "抖" 了一下.

要尽量避免这种情况, 就要合理地设置 ``innodb_io_capacity`` 的值,
并且平时要多 **关注脏页比例, 不要让它经常接近75%**.

脏页比例是通过 ``Innodb_buffer_pool_pages_dirty/Innodb_buffer_pool_pages_total``
得到的, 具体的命令参考下面的代码:

.. code-block:: mysql

   mysql> select VARIABLE_VALUE into @a from global_status where VARIABLE_NAME = 'Innodb_buffer_pool_pages_dirty';
   select VARIABLE_VALUE into @b from global_status where VARIABLE_NAME = 'Innodb_buffer_pool_pages_total';
   select @a/@b;
