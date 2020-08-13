============
 重定向全解
============

了解一下标准输入输出
====================

执行一个 shell 命令行时通常会自动打开三个标准文件;

1. 标准输入文件 (stdin) 通常对应终端的键盘

2. 标准输出文件 (stdout)

3. 标准错误输出文件 (stderr)

2 和 3 这两个文件都对应终端的屏幕;

进程将从标准输入文件中得到输入数据,
将正常输出数据输出到标准输出文件 --> 显示器;
将错误信息送到标准错误文件 --> 显示器;

.. image:: ./images/stdin_out_err.jpg


当不想把一些进程处理后信息输出到显示器时, 就引出了重定向;


重定向
======

- 重定向标准输出, 包括两种

  #. **>** ( 覆盖 ), 等价 ``1>``
     将命令执行的结果 **输出** 到指定文件, 非显示器

  #. **>>** ( 追加 ), 等价 ``1>>``
     将命令执行的结果 **追加** 到指定文件，非显示器

- 重定向标准输入, 包括两种

  #. **<**
     将命令中接收的输入途径, 由键盘改为指定文件

  #. **<<**
     命令序列传递到一个交互程序或者命令中

- 重定向标准错误, 包括两种

  #. 2> ( 覆盖 )
     将命令执行的结果 **输出** 到指定文件

  #. 2>> ( 追加 )
     将命令执行的结果 **追加** 到指定文件

- 两个特殊文件

  - /dev/null 过滤标准错误信息

    意思就是不想显示结果就输出到这里面

  - /dev/zero 创建指定长度的文件

常见用法
========

- 重定向标准输出和重定向标准错误到同一个文件中, 有如下方式:

  #. ``2>&1``
  
  #. ``>&``

  #. ``&>``

- 清空文件 ``>filename.txt``

- 从文件中读取密码

  .. code-block::

     # cat passwd.txt
     123456
     123456

  .. code-block::

     [root@work ~]# useadd demo
     [root@work ~]# passwd demo < passwd.txt
     Changing password  for user demo.
     New password: BAD PASSWORD: it is too simplistic/systematic
     BAD PASSWORD: is to simple
     Retry new password: passwd: all authentication tokens updated successfully.


- 注意 EOF 结束标志

  .. code-block::

     [root@work ~]# passwd demo << EOF
     > abcdef
     > abcdef
     > EOF
     Changing password  for user demo.
     New password: BAD PASSWORD: it is too simplistic/systematic
     BAD PASSWORD: is to simple
     Retry new password: passwd: all authentication tokens updated successfully.
     
