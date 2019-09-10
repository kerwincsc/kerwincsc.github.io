================
 02 salt-master
================

配置文件说明
============

- 约定:

  被注释了的值, 且其后跟一个空行的, 是默认值, 不需要设置;

  注释后未跟空行的值是示例, 不是默认值;


主要配置设定
------------

.. code-block:: shell

   # Master 会自动包含所有在 master.d/\*.conf 下的配置文件
   default_include: master.d/*.conf

   # 接口地址被绑定到这里:
   interface: 0.0.0.0

   # Master 是否应该监听 IPv6 的连接; 如果设置为 True,
   # 则接口选项也应该被调整, 比如: "interface: '::'"
   ipv6: False

   #  发布服务器使用的TCP端口 ( 应该是用来向 Slave 发送任务的 )
   publish_port: 4505

   # salt 将用哪个用户运行. salt 将更新所有权限, 以允许指定的用户运行master.
   # job 缓存是例外, 如果 user 更改, 必须删除 job 缓存.
   # 如果修改的文件引起冲突, 请将 verify_env 设置为 false.
   user: root

   # 通信接口使用的端口. ret_port 是用于文件服务器, 授权, job 返回的接口;
   ret_port: 4506

   # 指定守护进程 ID 文件的位置
   pidfile: /var/run/salt-master.pid

   # root_dir 根目录用于这些选项: pki_dir, cachedir, sockdir, log_file,
   # autosign_file, autoreject_file, extension_modules, key_logfile,
   # pidfile, autosign_grains_dir;
   root_dir: /

   # Master 的配置文件路径
   conf_file: /etc/salt/master

   # 用来存放公钥数据的目录
   pki_dir: /etc/salt/pki/master

   # 密钥缓存. 提高 Master 接受大量密钥的速度.
   # 可用选项: 'sched' (定期更新)
   # 注意, 启用这个特性意味着在默认 60s 的维护循环长度时间内 Minions 不能成为目标.
   key_cache: ''

   # 储存 job 和缓存数据的目录
   # 此目录可能包含一些敏感数据, 应该受到相应的保护
   cachedir: /var/cache/salt/master

   # 自定义模块的目录. 此目录可包含每一种 Salt 模块类型的子目录,
   # 比如, 'runner', 'output', 'wheel', 'modules', 'states', 'returners',
   # 'engines', 'utils' 等.
   extension_modules: /var/cache/salt/master/extmods

   # 自定义模块的目录.
   # 与 'extension_modules' 相似, 但是它可以接收路径数组
   module_dirs: []

   # 启动时验证并设置配置目录的权限
   verify_env: True

   # 设置将旧作业信息保留在作业缓存中的小时数
   keep_jobs: 24

   # 客户端请求有关运行作业的信息时等待的秒数
   gather_job_timeout: 10

   #  设置 salt 命令和 api 的默认超时时间, 默认 5 秒;
   timeout: 5

   # loop_interval 选项控制 Master 的维护进程检查周期的秒数.
   # 此进程更新文件服务器后台, 清除 job 缓存, 执行调度程序.
   loop_interval: 60

   # 设置 salt 命令使用的默认输出. 默认为 "nested" (嵌套)
   output: nested

   # 设置额外的目录列表来搜索 Salt 输出.
   outputter_dirs: []

   # 设置 salt 命令使用的默认输出文件. 默认是输出到命令行而不是文件.
   # 与命令行选项 "--out-file" 功能相同, 对于所有命令, 仅将其设置为单个文件.
   output_file: None

   # 当任务发布了, 告诉客户端显示 jid (job id)
   show_jid: False

   # 默认情况下, 输出是彩色的. 设定颜色值为 `False` 会禁止彩色输出.
   color: True

   # 不要从嵌套的结果和状态输出中剥离彩色输出. ( 默认是 `True` )
   strip_colors: False

   # 把 `cli_summary` 值设为 `True` (默认是 `False`) 来显示目标 Minions 的数量,
   # 返回 Minions 的数量和没有返回的 Minions 的数量的汇总.
   cli_summary: False

   # 设置用来存放 unix 套接字的目录
   sock_dir: /var/run/salt/master

   # 当使用 lspci 和/或 dmidecode 填充 master的 grains 时,
   # master 可能需要一段时间才能启动.
   # 如果你想看你 Master 的 GPU 硬件数据, 就打开它.
   enable_gpu_grains: False

   # Master 维护一个 job 缓存. 这是很好的附加功能,
   # 然而对于大规模 ( 超 5000 台 ) 的在 Master 上部署, 这可能是一个负担.
   # 禁用 `作业缓存` 将使以前执行的作业对作业系统不可用，通常不建议这样做 .
   job_cache: True

   # 通过 cachedir 或数据库中的 cache 子系统缓存 minion grains, pillar 和 mine 数据 
   minion_data_cache: True

   # 用于 Minion 数据缓存的缓存子系统模块.
   cache: localfs
   # 启用快速内存缓存加速并设置过期时间
   memcache_expire_seconds: 0
   # 为每个缓存存储设置项的 memcache 限制.
   memcache_max_items: 1024
   # 每次高速缓存存储器得到完全清除时, 所有过期的项都会被清除, 而不仅仅是最旧的项;
   memcache_full_cleanup: False
   # 允许收集 memcache 状态并且将它记录在 `debug` 日志级别.
   memcache_debug: False

   # 在给定的返回器中储存返回值.
   # 设定此值的同时要指定返回器, 可选返回器有 elasticsearch, etcd, memcache, mongo,
   # mysql, postgres, redis, smtp, sqlite3, syslog, and xmpp 等
   event_return: mysql

   # 在繁忙的系统上，启用事件返回会给返回者的存储系统带来相当大的负载;
   # 事件可以在主服务器上排队, 并使用单个事务以批处理的方式存储多个事件.
   # 默认情况下, 事件不排队.
   event_return_queue: 0

   # 仅返回与白名单中的标记匹配的事件, 支持全局匹配.
   event_return_whitelist:
     - salt/master/a_tag
     - salt/run/*/ret

   # 储存所有不在黑名单中的事件返回, 支持全局匹配.
   event_return_blacklist:
     - salt/master/not_this_tag
      - salt/wheel/*/ret

   # 传递非常大的事件会导致消耗大量内存.
   # 此值调整 master 总线上允许的最大消息大小
   # 该值以字节表示;
   max_event_size: 1048576

   # Windows 平台缺少 POSIX IPC, 必须依赖较慢的基于 TCP 的进程间通信.
   # 在此类系统上, 将 ipc_mode 设置为 'tcp'
   ipc_mode: ipc

   # 当 ipc_mode 被设置为 tcp 时, 覆盖 minion 使用的默认 TCP 端口;
   tcp_master_pub_port: 4510
   tcp_master_pull_port: 4511

   # 默认情况下, master 的 AES 密钥每 24 小时循环一次.
   # 下一个跟在密钥循环后的命令将会触发一个来自 minion 的密钥刷新,
   # 这将导致在密钥刷新后 minions 不会响应第一个命令.
   #
   # 将 `ping_on_rotate` 设置为 `True`, 来告诉 master 在 AES 密钥刷新后
   # 立即 ping 所有的 minions.
   # 这应该可以缓解这样一个问题: 在一个密钥被循环之后, minion 开始似乎没有响应;
   # 请注意, `ping_on_rotate` 可能会在 minions 重连时的密钥循环事件之后,
   # 立即对 master 造成高负载.
   # 仔细想想, 如果这个 salt master 管理着大量的 minions.
   #
   # 如果禁用, 建议通过使用 'key' 标记侦听 'aes_key_rotate'
   # 事件并采取适当的操作来处理此事件.
   ping_on_rotate: False

   # 默认情况下, 当 minion 的密钥被删除后, master 会删除这个 minion 的数据.
   # 为了保留被删除密钥的 minion 的缓存, 把 `preserve_minion_cache` 设为 `True`.
   # 警告: 如果受到攻击的 minons 使用之前被删除的 minion ID 进行身份验证, 可能有安全隐患.
   preserve_minion_cache: False

   # 允许或拒绝 minions 请求它们自己的密钥吊销.
   allow_minion_key_revoke: True

   # 如果在大批量的安装中使用了 `max_minion`, master 可能会遇到高负载的情况,
   # 因为 master 不得不在每次的身份验证中检查已连接的 minion 的数量.
   # 此缓存向所有的 MWorker 进程提供所有已连接的 minion 的 ID,
   # 且极大地提高了 `max_minons` 的性能.
   con_cache: False

   # master 能够包含来自其它文件的配置文件.
   # 向此选项传递一个路径列表来开启这个功能.
   # 路径可以是相对路径, 也可以是绝对路径; 如果是相对路径,
   # 它们将被认为是相对于主 master 配置文件 ( 就是这个文件 ) 存在的目录.
   # 路径可以使用 shell 风格的通配符.
   # 如果没有与传递给此选项的路径相匹配的文件, 那么 master 将会记录一个警告消息.
   # 从某个其它路径包含一个配置文件:
   include: /etc/salt/extra_config
   # 从一些文件和目录包含配置:
   include:
     - /etc/salt/extra_config
   # 这里的配置风格应该是 YAML 的, 即缩进两格和连字符后空一格.

大规模调整设定
==============

.. code-block:: shell

   # 最大打开文件数
   # 每一个连接到 master 的 minion `至少` 使用一个文件描述符, master 订阅连接.
   # 
