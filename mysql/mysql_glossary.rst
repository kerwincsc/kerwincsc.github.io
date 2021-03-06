==============
 Mysql 词汇表
==============

名词解释
========

索引
----

索引的出现其实就是 **为了提高数据查询的效率**

- 哈希

- 有序数组

- N 叉树

覆盖索引
~~~~~~~~

在查询里, 如果索引 k 已经 "覆盖了" 我们的查询需求, 我们称为覆盖索引.

索引下推
~~~~~~~~

索引下推优化  index condition pushdown, 从 5.6 开始引入

可以在索引遍历过程中, 对索引中包含的字段先做判断, 直接过滤掉不满足条件的记录,
**减少回表次数**


锁的分类
--------

按加锁范围分

全局锁
~~~~~~

对整个数据库实例加锁.

使用场景: 做全库逻辑备份

表级锁
~~~~~~

有两种, **表锁** 和 **元数据锁** , meta data lock, MDL

- 元数据锁

  5.5 中引入

  当对一个表做 **增删改查** 操作的时候，加 ``MDL读锁``;
  当要对表做 **结构变更** 操作的时候, 加 ``MDL写锁``
  
  事务中的 MDL 锁, 在语句执行开始时申请, 但是语句结束后并不会马上释放,
  而会等到整个事务提交后再释放.

行锁
~~~~

- 两阶段锁协议

  在 InnoDB 事务中, 行锁是在需要的时候才加上的,但并不是不需要了就立刻释放,
  而是要等到 **事务结束时才释放**. 这个就是两阶段锁协议.

  如果你的事务中需要 **锁多个行, 要把最可能造成锁冲突, 最可能影响并发度的锁** 尽量往后放.

- 死锁

  当并发系统中不同线程出现 **循环资源依赖**, 涉及的线程都在等待别的线程释放资源时,
  就会导致这几个线程都进入 **无限等待** 的状态, 称为死锁.



  

----------------

- MVCC

  数据库的多版本并发控制 Multi-Version Concurrency Control

- 两阶段提交

  为什么必须有 **两阶段提交** 呢? 这是为了让两份日志 (redo log 和 bin log)
  之间的逻辑一致

- 回表

  回到主键索引树搜索的过程, 称为回表;

  先索引扫描, 再通过 ID 去取索引中未能提供的数据, 即为回表;---> 更容易理解

- 事务

  事务就是要保证一组数据库操作，要么全部成功，要么全部失败

- 隔离级别

  1. 读未提交 read uncommitted

     一个事务还没提交时, 它做的变更就能被别的事务看到

  2. 读提交 read committed

     一个事务提交之后，它做的变更才会被其他事务看到

  3. 可重复读 repeatable read

     一个事务执行过程中看到的数据,
     总是跟这个事务在启动时看到的数据是一致的.

     当然在可重复读隔离级别下, 未提交变更对其他事务也是不可见的.

  4. 串行化 serializable

     对于同一行记录, "写" 会加 "写锁", "读" 会加 "读锁".
     当出现读写锁冲突的时候,后访问的事务必须等前一个事务执行完成,
     才能继续执行.

  - 为了解决当数据库上有多个事务同时执行的时候,
    可能出现的脏读 (dirty read), 不可重复读 (non-repeatable read),
    幻读 (phantom read) 问题.

- redo log

  用于保证crash-safe能力

- 最左前缀原则

  只要满足最左前缀, 就可以利用索引来加速检索;

  这个最左前缀可以是联合索引的 **最左** N 个字段, 也可以是字符串索引的 **最左** M 个字符

参数说明
========
  
- ``innodb_flush_log_at_trx_commit`` 

  此参数为 1 时, 表示每次事务的 redo log 直接持久化到磁盘.

  这个参数建议设置成 1, 这样可以保证 MySQL 异常重启之后数据不丢失

- ``sync_binlog`` 同步 binlog

  设置成 1 时, 表示每次事务的 binlog 持久化到磁盘.

  这个参数也建议设置成 1, 可以保证 MySQL 异常重启之后 binlog 不丢失

- ``transaction-isolation`` 事务隔离级别

  设置为 **READ-COMMITTED**, 比如从 Oracle 迁移到 Mysql.
  
其它
====

- "可重复读" 的场景

  假设你在管理一个个人银行账户表. 一个表存了每个月月底的余额, 一个表存了账单明细.
  这时候你要做数据校对, 也就是判断上个月的余额和当前余额的差额,
  是否与本月的账单明细一致. 你一定希望在校对过程中, 即使有用户发生了一笔新的交易,
  也不影响你的校对结果.

  这时候使用 **可重复读** 隔离级别就很方便. 事务启动时的视图可以认为是静态的,
  不受其他事务更新的影响.

脏页
====

当内存数据页跟磁盘数据页内容不一致的时候, 称这个内存页为"脏页"

干净页
======

内存数据写入到磁盘后, 内存和磁盘上的数据页的内容就一致了, 称为 "干净页"

.. _tps:

TPS
===

Transaction Per Second 每秒事务处理量
