================
 性能优化工具集
================

性能分析
========

mpstat
------

- ``mpstat -P ALL 5`` **-P ALL** 表示监控所有 CPU, 后面数字 5 表示间隔 5
  秒后输出一组数据.

pidstat
-------

- ``pidstat -u 5 1`` 间隔 5 秒后输出一组数据, **-u** 表示 CPU 指标;
  可以用来查看具体的任务报告

压测工具
========

stress
------

- 模拟 CPU 使用率 100% 的场景, 即不停地执行 sqrt

  .. code-block:: shell

     $ stress --cpu 1 --timeout 600

- 模拟 I/O 压力, 即不停地执行 sync

  .. code-block:: shell

     $ stress -i 1 --timeout 600
 
- 模拟多进程

  .. code-block:: shell

     # 模拟 8 个进程
     $ stress -c 8 --timeout 600
FAQ
~~~

- stress 模拟 I/O 压力时, iowait无法升高的问题.

  是因为案例中 stress 使用的是 **sync()** 系统调用, 它的作用是 **刷新缓冲区内存到磁盘中**.
  对于新安装的虚拟机, 缓冲区可能比较小, 无法产生大的 IO 压力,
  这样大部分就都是 **系统调用的消耗** 了. 所以, 你会看到只有系统 CPU 使用率升高.

  解决方法是使用 stress 的下一代 **stress-ng**, 它支持更丰富的选项,
  比如 ``stress-ng -i 1 --hdd 1 --timeout 600`` (--hdd 表示读写临时文件 )

- pidstat 输出中没有 **%wait** 的问题

  是因为 CentOS 默认的 sysstat 稍微有点老, 源码或者 RPM 升级到 11.5.5 版本以后就可以看到了.
  而Ubuntu的包一般都比较新, 没有这个问题.

- mpstat 无法观测的问题

  案例中是等待 5 秒后输出 1 次结果就停止了, 更好的做法是持续监控一段时间,
  比如持续观测 20 次: ``mpstat -P ALL 5 20``
