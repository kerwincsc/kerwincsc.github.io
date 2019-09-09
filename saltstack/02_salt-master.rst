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
