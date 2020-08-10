=====================
 ss - 套接字统计数据
=====================

ss - socket statistic 查看套接字的工具, 功能比 netstat 更加完善;

ss [选项] [过滤器]

案例
====

- ss -t -a

  展示所有的监听的和未监听的 tcp 套接字

- ss -t -a -Z

  **-Z** 是 SELinux 相关, 不作涉及

- ss -u -a

  展示所有的 udp 套接字

- ss -o state established '( dport = :ssh or sport = :ssh )'

  展示所有已建立的 ssh 连接

- ss -x src /tmp/.X11-unix/*

  找出所有的连接到 X 服务器的本地进程

- ss -o state fin-wait-1 '( sport = :http or sport = :https )' dst 193.233.7/24

  列出所有的有关 193.233.7/24 网络的在 FIN-WAIT-1 状态的 tcp 套接字并查看它们的计时器;

选项
====

.. csv-table:: ss 可选项
   :header: 选项, 描述

   "-H, --no-header", 不展示标题行
   "-n, --numeric", 不将服务名解析为相应的 ip 和端口
   "-r, --reslove", "与上面相反, 尝试将 ip 和端口解析为相应的服务"
   "-a, --all", "展示监听的与未监听 ( 对于 tcp, 表示已建立的链接 ) 的套接字"
   "-l, --listening", "仅展示监听的套接字 ( 默认不加此项 )"
   "-o, --options", "展示计时器信息 [#ss_optioins]_"
   "-e, --extended", "详细显示套接字信息 [#ss_extended]_"
   "-m, --memory", "展示套接字内存使用情况 [#ss_memory]_"
   "-p, --processes", "展示使用套接字的进程 [#ss_processes]_"
   "-i, --info", "展示内部的 TCP 信息"
   "-K, --kill", "试图强行关闭套接字. [#ss_kill]_ "
   "-s, --summary", "打印汇总的统计数据 [#ss_summary]_"
   "-N NSNAME, --net=NSNAME", "切换到指定的网络命名空间名"
   "-b, --bpf", "展示套接字 :term:`BPF` 过滤器 [#ss_bpf]_"
   "-0, --packet", "展示 PACKET 套接字 ( 等同于 ``-f link``)"
   "-4, --ipv4", "... IPv4 ... ( 等同于 ``-f inet``)"
   "-6, --ipv6", "... IPv6 ... ( 等同于 ``-f inet6``)"
   "-t, --tcp", "... tcp ..."
   "-u, --udp", "... udp ..."
   "-d, --dccp", "... dccp ..."
   "-w, --raw", "... raw ..."
   "-x, --unix", "... unix ... ( 等同于 ``-f unix``)"
   "-S, --sctp", "... sctp ..."
   "--vsock", "... vsock ... ( 等同于 ``-f vsock``)"
   "-f FAMILY, --family=FAMILY", "展示 FAMILY [#ss_family]_ 类型的套接字"
   "-A QUERY [#ss_query]_, --query=QUERY,\n --socket=QUERY", "以 **逗号** 分隔要转储的套接字表"
   "-D FILE [#ss_d_file]_, --diag=FILE", "不显示任何内容,只在应用筛选器后将有关 TCP 套接字的原始信息转储到文件中"
   "-F FILE, --filter=FILE", "从 FILE 中读取过滤信息 [#ss_f_file]_"
   "FILTER := [ state :ref:`STATE-FILTER<ss_state_filter>` ] [ EXPRESSION ]", "需要参考官方文档"

.. _ss_state_filter:

状态过滤器
==========

允许构造任意状态集以匹配. 它的语法是跟在 state 关键字和 exclude 关键字之后的状态标识符的序列;

可用标识符有:

- 所有标准的 TCP 状态: established, syn-sent, syn-recv, fin-wait-1, fin-wait-2,
  time-wait, closed, close-wait, last-ack, listen 和 closing

- all -> 所有的状态

- connected -> 所有的除了 listen 和 closed 的状态

- synchronized -> 所有的除了 syn-sent 的 connected 状态

- bucket -> 被当作微型套接字的状态, 如 time-wait 和 syn-recv

- big -> 与 bucket 相反;

-------------------

.. [#ss_optioins] 形如: ``timer:(keepalive,103min,0)``
.. [#ss_extended] 会多出两个字段, 形如: ``ino:236508 sk:ffff9479b5b44000 <->``
.. [#ss_memory] 形如: ``skmem:(r0,rb495264,t0,tb87040,f0,w0,o0,bl0,d0)``
.. [#ss_processes] 形如: ``users:(("sshd",pid=28959,fd=3),("sshd",pid=28957,fd=3))``
.. [#ss_kill] 此选项显示成功关闭的套接字, 并自动跳过内核不支持关闭的套接字.
   它只支持 IPv4 和 IPv6 套接字;
.. [#ss_summary] 此选项不解析从各种源获取的汇总的套接字列表.
   当套接字的数量太大以至于解析 /proc/net/tcp 非常困难时, 它非常有用.
.. [#ss_bpf] 仅管理员有权获取这些信息
.. [#ss_family] 可以是: unix, inet, inet6, link, netlink, vsock
.. [#ss_query] 可以是 all, inet, tcp, udp, raw,  unix, packet, netlink,
   unix_dgram, unix_stream, unix_seqpacket, packet_raw, packet_dgram,
   dccp, sctp, vsock_stream, vsock_dgram
.. [#ss_d_file] 如果 FILE 是 ``-``, 就使用标准输入
.. [#ss_f_file] 文件的每一行都被解释为单个命令行选项. 如果文件是 **-**, stdin 将被使用;
