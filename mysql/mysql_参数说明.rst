================
 MySQL 参数说明
================

innodb
======

.. _innodb_file_per_table:

innodb_file_per_table
---------------------

表数据既可以存在 **共享表空间** 里, 也可以是 **单独的文件**.
这个行为是由参数 ``innodb_file_per_table`` 控制的

  - 这个参数设置为 OFF 表示的是,
    表的数据放在系统共享表空间, 也就是跟数据字典放在一起;

  - 这个参数设置为 ON 表示的是,
    每个 InnoDB 表数据存储在一个以 **.ibd** 为后缀的文件中;

从 MySQL 5.6.6 版本开始, 默认值就是 ON 了.

- 建议

  不论使用 MySQL 的哪个版本, 都将这个值设置为 ON.
  因为, 一个表单独存储为一个文件更容易管理,
  而且在你不需要这个表的时候, 通过 ``drop table`` 命令,
  系统就会直接删除这个文件. 而如果是放在共享表空间中, 即使表删掉了,
  空间也是不会回收的;



