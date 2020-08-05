=========
 inotify
=========

inotifywait
===========

- 用法

  inotifywait file1 [, file2]

- 参数解析

  - @<file>

  - -c, --csv 

  - --timefmt <fmt> 设定可被 strftime 接受的时间格式字符串

  - --format <fmt>

    - %w 事件发生时, 代表被监听文件名

    - %f 当在目录中发生事件时, 将用导致事件发生的文件名替换.
      否则, 将替换为空字符串

    - %e 以逗号分隔多个事件名;

    - %Xe 以 X 分隔多个事件名; X 只能是单个字符

    - %T 以在 --timefmt [#timefmt]_ 中指定的形式替换为当前时间;


- 监听事件

  .. csv-table:: 可监听事件列表
     :header: "事件名", "描述"
     :widths: 20, 40

     ACCESS, 被监听的文件或被监听目录中的文件被 **读取**
     MODIFY, 被监听的文件或被监听目录中的文件被 **写入**
     ATTRIB, "元数据被修改; 包括 **时间戳**, **文件权限**, **扩展属性** 等"
     CLOSE_WRITE, 文件以可写的模式打开后关闭; 不意味着文件有写入;
     CLOSE_NOWRITE, 文件以只读的模式打开后关闭;
     CLOSE, "文件被关闭, 而不管它是如何打开的 [#close]_"
     OPEN, 被打开
     MOVED_TO, 文件或目录被移动到监听目录中
     MOVED_FROM, 监听目录中有文件或文件夹被移出
     MOVE, 类比 CLOSE [#move]_
     MOVE_SELF, 监听目录或文件自身被移动 [#move_self]_
     CREATE, 在监听的目录中创建了文件或目录
     DELETE, 监听目录中的文件或目录被删除
     DELETE_SELF, 删除监听目录或文件自身 [#delete_self]_
     UNMOUNT,  监视的文件或目录所在的文件系统已卸载 [#unmount]_


inotifywatch



介绍
====

linux 实时文件事件监听工具;

inotify 是 Linux 内核 2.6.13 (June 18, 2005) 版本新增的一个子系统 (API),
它提供了一种监控文件系统 ( **基于inode** 的 ) 事件的机制,
可以监控文件系统的变化如文件修改, 新增, 删除等, 并可以将相应的事件通知给应用程序;

inotify 既可以监控文件, 也可以监控目录.
当监控目录时, 它可以同时监控目录及目录中的各子目录及文件;

inotify 使用文件描述符作为接口, 因而可以使用通常的文件 I/O 操作
select, poll 和 epoll 来监视文件系统的变化;


----------------------

.. rubric:: 备注

.. [#timefmt] 适合传递到 strftime 的格式字符串;

.. [#close] 实际上是通过监听 close-write 和 close-nowrite 来实现的,
            因此接收到的所有 close 事件都将作为其中之一输出, 而不仅仅是 close;

.. [#move] 应该会在输出 MOVED_TO 或 MOVED_FROM 的同时输出 MOVE,
           但是没有, 非常奇怪;

.. [#move_self] 此事件后, 移动了的目录或文件不再被监听

.. [#delete_self] 和 move_self 类似. 请注意, 即使没有显式地监听此事件, 也可能发生此事件;

.. [#unmount] 和 move_self 类似. 请注意, 即使没有显式地监听此事件, 也可能发生此事件;


