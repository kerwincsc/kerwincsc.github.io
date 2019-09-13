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
   #
   # 每一个连接到 master 的 minion `至少` 使用一个文件描述符, master 订阅连接.
   # 如果有足够多的 minion 连接, 你可能会在控制台上看到:
   # (接着 salt-master 崩溃)
   # 太多的打开文件 ( tcp_listener.cpp:335)
   # 中止
   #
   # 默认情况下, 此值是 `ulimit -Hn` 值中的一个 (其实就返回一个值),
   # 也就是最大打开文件数的硬限制
   #
   # 如果你想设定一个超出默认值的值, 取消注释并配置此选项.
   # 记住, 此值 `不能` 高于硬限制. 提高硬限制取决于你的系统和发行版,
   # 最好是去网上搜索, 比如: `raise max open files hard limit debian`
   max_open_files: 100000

   # 启动的工作线程数. 这些线程被用来管理由 minion 向 master 的返回调用.
   # 如果 master 看起来运行缓慢, 就提高线程的数量.
   # 此项设置不能小于 3;
   worker_threads: 5

   # 设置 ZeroMQ 高水位
   # http://api.zeromq.org/3-2:zmp-setsockopt

   # 监听队列大小 / 积压队列
   zmp_backlog: 1000

   # 发布者接口 ZeroMQPubServerChannel
   pub_hwm: 1000
   # 不太明白是什么意思, 留着以后再看看

   # master 为每个事件分配内存并且不回收它;
   # 要设置内存分配的高水位, 使用 ``ipc_write_buffer`` 为消息缓存设定一个高水位
   # 值: 以字节为单位. 设置为 'dynamic', 让 Salt 为你选择一个值.
   # 默认是关闭的; (Default is disabled)
   ipc_write_buffer: 'dynamic'

   # 这两个批处理设置, `batch_safe_limit` 和 `batch_safe_size`,
   # 用于自动切换到批处理模式执行.
   # 如果一个命令被发送到多于 <batch_safe_limit> 个的 minion,
   # 那么将分 <batch_safe_size> 批运行命令;
   # 如果没有指定 `batch_safe_size`, 将默认使用 8.
   # 如果没有指定 `batch_safe_limit`, 那么自动批处理将不会发生.
   batch_safe_limit: 100
   batch_safe_size: 8

   # Master 状态允许以接近定义的间隔从 master 触发状态事件.
   master_stats: False
   master_stats_event_iter: 60


安全设定
========

.. code-block:: shell

   # 启用 Master 私钥的密码保护. 虽然字符串值是可以被接受的,
   # 但是密码应该被储存外部防御机制中并通过 sdb 检索.
   # 关于 sdb 可参考: https://docs.saltstack.com/en/latest/topics/sdb/.
   # 默认情况下, 密码保护是关闭的, 但以下是一个sdb 配置文件和查询的示例
   masterkeyring:
     driver: keyring
     service: system

   key_pass: sdb://masterkeyring/key_pass

   # 启用 Master `signing_key` 的密码保护.
   # 仅当 `master_sign_pubkey` 被设置为 `True` 时才启用. 默认是禁止的.
   master_sign_pubkey: True
   signing_key_pass: sdb::/masterkeying/signing_pass

   # 启用 `open mode`, 此模式仍然保持加密, 但是关闭了身份验证,
   # 这仅适用于高度安全的环境或者密钥最终处于糟糕状态的情况
   # 如果在 `open mode` 下运行, 自行承担风险;
   open_mode: False

   # 启用 `auto_accept`, 此设置将自动接受所有的即将从 minion 到来的公钥;
   # 注意, 这是不安全的;
   auto_accept: False

   # 创建新的密钥时, 被生成的密钥的大小;
   keysize: 2048

   # 一个即将到来的在 `pki_dir/minion_autosign/keyid` 具有匹配名称的公钥将被自动接受,
   # 时间以分钟为单位;
   # 当 master 检查 `minion_autosign` 目录时, 过期的自动签名密钥将被移除;
   # 0 等于不会超时
   autosign_timeout: 120

   # 如果指定了 `sign_file`, 在 `autosign_file` 中指定的即将到来密钥将被自动接受.
   # 这是不安全的. 支持正则表达式和全局行. 此文件除所有者外必须是只读的.
   # 使用 `permissive_pki_access` 来允许组的写访问.
   autosign_file: /etc/salt/autosign.conf

   # 工作原理类似于 `autosign_file`, 但是允许你指定将自动拒绝密钥的 minion ID
   # 将自动覆盖 `autosign_file` 和 `auto_accept` 中的成员关系.
   autoreject_file: /etc/salt/autoreject.conf

   # 如果指定了 `autosign_grains_dir` 目录, 来自 minion 的
   # 即将进入的粒度值与定义在此目录的文件中的相匹配的密钥将自动被接受.
   # 这是不安全的. Minion 需要被配置以发送 `grains` (这个词不知道怎么翻译)
   autosign_grains_dir: /etc/salt/autosign_grains

   # 启用对 salt 密钥的访问; 这允许你以 root 运行 master 或 minion, 但使一个非 root 组被授权访问你的 `pki_dir`.
   # 为了使访问显式, `root` 必须属于已授权访问权限的组; 这可能非常不安全.
   # 如果指定了 `autosign_file`, 启用 `permissive_pki_access` 将允许组访问那个特定文件;
   permissive_pki_access: False

   # 允许 master 上的用户有权在 minion 上执行特定命令.
   # 应该谨慎处理此设置, 因为它向非 root 用户开放了执行功能.
   # 默认情况下, 此项功能是完全禁止的.
   publisher_acl:
     larry:
       - test.ping
       - network.*
   # 将下列用户或模块列入黑名单
   #
   # 此例将把所有非 sudo 用户列入黑名单, 包括运行任何命令的 root 用户
   # 它也会把模块 'cmd'列入黑名单. 默认情况下, 完全禁止;
   publisher_acl_blacklist:
     users:
       - root
       - '^(?!sudo_).*$'    # all non sudo users
     modules:
       - cmd

   # 对照系统上的用户检查客户端acl中配置的用户列表. 如果不存在, 则抛出错误.
   client_acl_verify: True

   # 当用户有 sudo 权限去访问 salt 命令时, 强制执行 `publisher_acl` & `publisher_acl_blacklist`
   sudo_acl: False

   # 外部 auth 系统使用 Salt auth 模块对访问 Salt 系统区域的用户进行鉴定和确认;
   external_auth:
     pam:
       fred:
         - test.*
   #
   # 新生成的令牌存活的时间 ( 以秒为单位 ). 默认: 12 小时
   token_expire: 43200
   #
   # 允许 eauth 用户指定他们生成的令牌的过期时间. (external auth)
   # 布尔值适用于所有用户，或者可以给出一个包含白名单eauth后端和用户名的字典
   token_expire_user_override:
     pam:
       - fred
       - tom
     ldap:
       - gary
   token_expire_user_override: False

   # 将其设置为 True, 以启用将计算过的用户的 auth 列表保存在令牌文件中.
   # 默认情况下这是禁用的，并且每次都计算或请求 eauth 驱动程序的 auth 列表
   keep_acl_in_token: False

   # 用于为用户获取授权访问列表的 Auth 子系统模块.
   # 默认情况下, 它与用于外部身份验证的模块相同.
   eauth_acl_module: django

   # 允许 minion 向 master 推送文件. 为了安全考虑, 此项默认禁止;
   file_recv: False
   
   # 给可以被推向 master 的文件的大小设置一个硬性限制.
   # 它将被解释为按兆字节算. 默认: 100
   file_recv_max_size: 100

   # 对从 master 发布的消息进行签名验证.
   # 这将导致 master 对发布到其事件总线上的所有消息进行加密签名,
   # 然后, minion 在对消息执行操作之前验证该签名.
   #
   # 此项默认是 False.
   #
   # 请注意, 为了方便与不同版本的 master 和 minion 的互操作,
   # 如果 `sign_pub_messages` 为 *True*, 但 minion 接收到的消息没有签名,
   # 则仍然接受消息并记录告警信息.
   # 相反地, 如果 `sign_pub_messages` 为 *False*,
   # 但 minion 收到一个已签名的消息, 此消息将被接受, 但不会校验消息的签名,
   # 并且会记录警告消息;
   # 此行为在 Salt 2014.1.0 中消失并且这两种情况将会引发 minion 抛出异常
   # 并丢弃消息;
   sign_pub_messages: False

   # 对从 minion 发布的消息进行签名验证.
   # 这需要 minion 对其发布给 master 的消息进行加密签名.
   # 如果 minion 没有签名, 就会在 'INFO' 日志级别记录此信息,
   # 并且丢弃此消息不会执行它.
   require_minion_sign_messages: False

   # 以下情况将丢弃消息, 当他们的签名不合法.
   # 请注意, 当此选项为 *False* 但 `require_minion_sign_messages` 为 *True* 时,
   # Minion *必须* 对他们的消息签名, 但是他们的签名有效性将被忽略.
   # 这两个配置选项存在以便 salt 基础结构可以逐渐移动到为 minion 消息签名
   drop_messages_signature_fail: False

   # 在 master 和 minion 间使用 TLS/SSL 加密连接.
   # 可以设置为一个包含与 Python 的 'ssl.wrap_socket' 方法对应的关键字参数字典
   # 默认为空.
   ssl:
       keyfile: <path_to_keyfile>
       certfile: <path_to_certfile>
       ssl_version: PROTOCOL_TLSv1_2

Salt-SSH 配置
=============

.. code-block:: shell

   # 定义要使用的默认 salt-ssh 名册模块
   roster: flat

   # 给 salt-ssh `flat` 传递一个可选的名册文件位置
   roster_file: /etc/salt/roster

   # 给 `flat` 名册文件定义位置, 以便当使用 Salt API 时, 他们能够被选择.
   # 管理员可以把名册文件放入这些位置.
   # 然后, 当调用 Salt API 时, `roster_file` 参数应该包含一个相对于这些位置的相对路径.
   # 那就是说,
   # "roster_file=/foo/roster" 会被解析为 "/etc/salt/roster.d/foo/roster"
   # 此特性防止通过 Salt API 传递不安全的自定义的名册;
   rosters:
     - /etc/salt/roster.d
     - /opt/salt/some/more/rosters

   # 登录时使用的 ssh 密码
   ssh_passwd: ''

   # 目标系统的 ssh 端口号
   ssh_port: 22

   # 要扫描的端口的逗号分隔列表
   ssh_scan_ports: 22,2222

   # salt-ssh 扫描端口的超时时间
   ssh_scan_timeout: 0.01

   # 通过 sudo 运行命令的布尔值
   ssh_sudo: False

   # 当建立了一个 SSH 连接时, 等待一个响应的秒数
   ssh_timeout: 60

   # 以什么用户登录
   ssh_user: root

   # salt-ssh 命令的日志文件
   ssh_log_file: /var/log/salt/ssh

   # 传入将插入到SHIM中用于salt-ssh调用的minion选项覆盖 (不太明白)
   # 本地 minion 配置不用于 salt-ssh.
   # 可以在 roster 中以每个 minion 为基础进行覆盖. (`minion_opts`)
   ssh_minion_opts:
     gpg_keydir: /root/gpg

   # 将此项设置为 *True* 以默认给 salt-ssh 使用 ~/.ssh/id_rsa 对 minion 进行身份验证;
   ssh_use_home_key: False

   # 将此项设置为 *True*, 默认 salt-ssh 将与 `-o IdentitiesOnly=yes` 一起运行;
   # 此选项适用于 ssh-agent 提供许多不同身份,
   # 并允许 ssh 忽略这些身份并使用选项中指定的唯一身份的情况
   ssh_identities_only: False

   # 只列出 salt ssh 的节点组. 每个组必须形成逗号分隔列表或 yaml 列表.
   # 当使用 salt-ssh 时, 此项有助于将 minion 分成易于瞄准的组.
   # 然后可以使用普通的 *-N* 参数将这些组作为 salt-ssh 的目标.
   ssh_list_nodegroups: {}

   # 如果在 roster 中没有找到某个 minion, salt-ssh 可以更新 flat roster 文件.
   # 将此项设置为 *True* 以启用它.
   ssh_update_roster: False

Master 模块管理
===============

.. code-block:: shell

   # 管理 master 端的模块加载

   # 增加额外的位置以寻找 master runners (不知道咋翻译, 先这样吧)
   runner_dirs: []

   # 增加额外的位置以寻找 master 实用工具 (master utils)
   utils_dirs: []

   # 启用 master 端的 Cython;
   cython_enable: False

状态系统设置
============

.. code-block:: shell

   # 状态系统使用一个 'top' 文件来告诉 minion 使用什么环境和模块.
   # state_file 文件是相对于基本环境的根定义的, 就像下面定义在
   # `文件服务器设置` 中的一样
   state_top: top.sls

   # master_top 选项通过创建一个用于生成外部 top 数据的可插拔系统来取代 external_nodes
   # external_node 选项被 master_tops 选项否决.
   #
   # 使用以下配置以获得经典的 external_nodes 系统的功能
   # master_tops:
   #   ext_nodes: <Sehll command which returns yaml>
   master_tops: {}

   # 在 minion 上使用渲染器来渲染状态数据
   renderer: jinja|yaml

   # 除 sls 模板外的, 所有模板默认的 Jinja 环境选项.
   jinja_env:
     block_start_string: '{%'
     block_end_string: '%}'
     variable_start_string: '{{'
     variable_end_string: '}}'
     comment_start_string: '{#'
     comment_end_string: '#}'
     line_statement_prefix:
     trim_blocks: False
     lstrip_blocks: False
     newline_sequence: '\n'
     keep_trailing_newline: False

   # sls 模板的 Jinja 环境选项
   jinja_sls_env:
     block_start_string: '{%'
     block_end_string: '%}'
     variable_start_string: '{{'
     variable_start_string: '}}'
     comment_start_string: '{#'
     comment_end_string: '#}'
     line_statement_prefix:
     line_comment_prefix:
     trim_blocks: False
     lstrip_blocks: False
     newline_sequence: '\n'
     keep_trailing_newline: False

   # failhard ( 分开来可译为: 死翘翘 ) 选项告诉 minion
   # 在状态执行中检测到第一个故障后立即停止, 默认为 *False*
   failhard: False

   # `state_verbose` 和 `state_output` 设置可被用来改变状态系统数据打印到显示器上的方式
   # 默认情况下, 打印所有数据. `state_verbose` 设置可被设为 *True* 或 *False*,
   # 当设置为 false 时, 所有结果为 true 且没有任何更改的数据都将被抑制.
   state_verbose: True

   # `state_output` 设置控制哪些结果将输出完整的多行
   # full, terse - 每个状态将被完整的 / 简洁的输出
   # mixed       - 仅错误状态将被完全的输出
   # changes     - 有改变的和错误的状态将被完全的输出
   # full_id, mixed_id, changes_id 和 terse_id 也是允许的;
   # 当设置时, 在输出中将状态 ID 用作名字.
   state_output: full

   # `state_output_diff` 设置更改是否返回来自成功状态的输出.
   # 当这些状态的简洁输出使日志混乱时非常有用. 设置为 true 以忽略它们
   state_output_diff: False

   # 通过设置为 *True*, 自动聚合所有支持 mod_aggregate 的状态.
   # 或者传递状态模块名称列表, 以便仅自动聚合这些类型.
   #
   # state_aggregate:
   #   - pkg
   state_aggregate: False

   # 通过设置为 *True*, 在状态运行中的每个函数完成执行时发送进程事件.
   # 进程事件的形式是这样的 'salt/job/<JID>/prog/<MID>/<RUN NUM>'
   state_events: False

文件服务器设置
--------------

.. code-block:: shell

   # Salt 运行一个以 zeromq 写成的轻量级的文件服务器向 minion 传送文件
   # 此文件服务器内置于 master 守护进程中, 不需要专用端口

   # 文件服务器工作在传递给 master 的环境中, 每个环境可以有多个根目录,
   # 多个文件根目录中的子目录不能匹配, 否则下载的文件将无法得到可靠的保证.
   # 需要一个基本环境来存放顶级文件.
   # 示例:
   # file_roots:
   #   base:
   #     - /srv/salt/
   #   dev:
   #     - /srv/salt/dev/services
   #     - /srv/salt/dev/states
   #   prod:
   #     - /srv/salt/prod/services
   #     - /srv/salt/prod/states
   file_roots:
     base:
       - /srv/salt

   # `master_roots` 配置状态编译器使用的 file_roots 字典的一个仅 master 副本
   # (a master-only copy)
   master_roots: /srv/salt-master

   # 当使用多个环境 ( 每个环境都有自己的顶级文件 ) 时, 默认行为是无序合并.
   # 为了防止 top 文件被合并在一起而只使用来自请求环境的 top 文件, 请将此值设为 *same*
   top_file_merging_strategy: merge # top file 合并策略

   # 要指定环境合并的顺序, 请在 `env_order` 选项中设置顺序.
   # 给定一个冲突, 最后一个匹配值将胜出.
   env_order: ['base', 'dev', 'prod']

   # 如果把 `top_file_merging_strategy` 设置为 *same* 且环境不包含一个 top 文件,
   # 则在环境中由 `default_top` 指定的 top 文件代替使用.
   default_top: base

   # `hash_type` 是在 master 服务器上发现文件的散列时使用的散列.
   # 默认值是 *fsha256*, 但是也支持 md5, sha1, sha224, sha384 和 sha512
   #
   # 警告: 虽然 md5 和 sha1 也得到了支持, 但是不要使用它们,
   # 因为它们很有可能发生冲突, 从而造成安全漏洞.
   #
   # 在更改此值之前, 应停止 master 服务器, 并清除所有 salt 缓存.
   hash_type: sha256

   # 可以在此调节文件服务器的缓冲大小
   file_buffer_size: 1048576

   # 一个正则表达式 ( 或一组表达式 ), 在将模块和状态同步到 minion 之前,
   # 将与文件路径匹配. 这包括受 file.recurese 状态影响的文件.
   # 例如, 如果您在 subversion 中管理自定义模块和状态,
   # 并且不想所有的 '.svn' 文件夹和内容同步到您的 minion,
   # 你可以将其设置为 '/\.svn($|/)'. 默认情况下不会忽略任何内容.
   file_ignore_regex:
     - '/\.svn($|/)' # /.svn 或 /.svn/
     - '/\.git($|/)' # /.git 或 /.git/

   # 一个全局文件 ( 或全局文件列表) 在将模块和状态同步到 minion 之前,
   # 将与文件路径匹配. 这与上面的 `file_ignore_regex` 类似,
   # 但它在 globs 上而不是 regex 上工作. 默认情况下不忽略任何内容.
   file_ignore_glob:
     - '*.pyc'
     - '*/somfolder/*.bak'
     - '*.swp'

   # 文件服务器后端
   #
   # Salt 支持模块化的文件服务器后端系统,
   # 该系统允许 Salt master 直接链接到第三方系统, 收集和管理 minion 可用的文件.
   # 可以配置多个后端, 并将按照定义后端的顺序搜索所请求的文件.
   # 默认设置只启用使用 "file_roots" 选项的标准后端 "roots".
   fileserver_backend:
     - roots
   #
   # 若要使用多个后端, 请按搜索顺序列出它们:
   fileserver_backend:
     - git
     - roots
   # 如果你不希望 file_server 在遍历文件系统树时跟随符号链接,
   # 请取消下面这一行的注释. 默认设置为 *True*.
   # 目前, 这只适用于默认的 `roots` fileserver_backend.
   fileserver_followsymlinks: False
   #
   # 如果不希望符号链接被视为它们指向的文件, 请取消注释下面的行.
   # 默认情况下, 此值设置为 *False*. 通过取消对下面一行的注释,
   # 在 master 上列出文件时检测到的任何符号链接都不会返回给 minion.
   fileserver_ignoresymlinks: True
   #
   # 默认情况下, salt 文件服务器完全递归到所有定义的环境中,
   # 以尝试查找文件. 若要限制此行为,
   # 使文件服务器只遍历包含 SLS 文件和特殊 salt 目录 ( 如 _modules ) 的目录,
   # 请启用以下选项. 对于文件根目录中有大量文件且性能受到影响的安装,
   # 这可能非常有用. 默认值为 *False*.
   fileserver_limit_traversal: False
   #
   # 文件服务器可以在每次更新文件服务器时关闭事件, 这些事件在默认情况下是禁用的,
   # 但是可以通过将此标志设置为 *True* 轻松打开;
   fileserver_events: False

   # Git 文件服务器端配置
   #
   # 用来指定用于 gitfs 的提供程序的可选参数.
   # 必须是 *pygit2* 或 *gitpython*.
   # 如果未设置, 则将尝试二者 ( 按该顺序 ),
   # 且已安装兼容版本的第一个将是所使用的提供程序.
   #
   gitfs_provider: pygit2

   # 与 `gitfs_password` 一起, 用来给 HTTPS 远程验证身份.
   gitfs_user: ''

   # 与 `gitfs_user`, 用来给 HTTPS 远程验证身份.
   # 如果仓库不使用身份验证, 就不需要此参数.
   gitfs_password: ''

   # 默认情况下, Salt 不会对 HTTP( 不是 HTTPS) 远程进行身份验证.
   # 此参数在 HTTP 启用身份验证. 启用此项, 风险自负. ( 有什么风险 ?)
   gitfs_insecure_auth: False

   # 与 `gitfs_privkey` 一起 ( 且 `gitfs_passphrase` 是可选的 ),
   # 用来对远程 SSH 进行身份验证. 远程 SSH 需要此参数 ( 或者每远程对应 )
   gitfs_pubkey: ''

   # 与 `gitfs_pubkey` 一起 ( 且 `gitfs_passphrase` 是可选的 ),
   # 用来对远程 SSH 进行身份验证. 远程 SSH 需要此参数 ( 或者每远程对应 )
   gitfs_privkey: ''

   # 此参数是可选的, 仅当用于身份验证的 ssh 密钥受密码短语保护时才需要;
   gitfs_passphrase: ''

   # 使用 git 文件服务器后端时, 至少需要定义一个远程 git.
   # 运行 salt master 的用户将需要 repo 的读取权限.
   #
   # 搜索 repo 以找到客户机请求的文件, 第一个拥有该文件的 repo 将返回该文件.
   # 当使用 git 后端时, 分支和标记被转换为 salt 环境.
   # 注意: *file://* repos 将被视为远程文件,
   # 因此要使用的 ref 必须作为 *local* refs 存在于该 repo 中.
   gitfs_remotes:
     - git://github.com/saltstack/salt-states.git
     - file:///var/git/saltmaster
   # `gitfs_ssl_verify` 选项明确规定, 当连接到 gitfs 后端时, 是否忽略 ssl 证书错误.
   # 如果您使用的是使用自签名证书的 git 后端, 则可能需要将此设置为 *False*,
   # 但请记住, 将此标志设置为默认值 *True* 以外的任何值都是安全问题,
   # 你可能需要尝试使用 ssh 传输.
   gitfs_ssl_verify: True
   #
   # `gitfs_root` 选项允许从存储库中的子目录提供文件.
   # 路径是相对于存储库的根定义的, 默认为存储库的根.
   gitfs_root: somefolder/otherfolder
   #
   # gitfs remotes 获取的 refspecs
   gitfs_refspecs:
     - '+refs/heads/*:refs/remotes/origin/*'
     - '+refs/tags/*:refs/tags/*'

Pillar 设置
===========

.. code-block:: shell

   # Salt Pillars 允许建立全局数据,
   # 这些数据可以基于 minion grain 过滤有选择地提供给不同的 minion.
   # Salt Pillar 的布局方式与文件服务器相同,
   # 包括环境, 顶级文件和 sls 文件.
   # 但是, Pillar 数据不需要采用 highstate 格式, 通常只是键 / 值对.
   pillar_roots:
     base:
       - /srv/pillar

   ext_pillar:
     - hiera: /etc/hiera.yaml
     - cmd_yaml: cat /etc/salt/yaml

   # 在 pillar 编译期间要递归解密的路径列表.
   # 此列表中的项可以格式化为简单字符串或键 / 值对,
   # 此键是 pillar 位置, 此值是用于 pillar 解密的渲染器.
   # 如果使用前者 ( 简单的字符串 ), 则将使用 `decrypt_pillar_default` 指定的渲染程序.
   decrypt_pillar:
     - 'foo:bar': gpg
     - 'lorem:ipsum:dolor'

   # 在 `decrypt_pillar` 选项中`用来区分嵌套数据结构的分隔符.
   decrypt_pillar_delimiter: ':'

   # 用于解密的默认渲染器 ( 如果没有为在 `decrypt_pillar` 中的给定 pillar 密钥指定一个 )
   decrypt_pillar_default: gpg

   # 允许用来给 pillar 解密的渲染器列表.
   decrypt_pillar_renderers:
     - gpg

   # `ext_pillar_first` 选项允许在文件系统 pillar 之前填充外部 pillar 源.
   # 这允许从 `ext_pillar` 定位文件系统 pillar.
   ext_pillar_first: False # 不明白这段配置

   # 允许使用 `pillar.ext` 按需使用外部 pillar
   on_demand_ext_pillar:
     - libvirt
     - virtkey

   # `pillar_gitfs_ssl_verify` 选项指定在连接 pillar gitfs 后端时
   # 是否忽略 ssl 证书错误. 如果您使用的是使用自签名证书的 git 后端,
   # 则可能需要将其设置为 false, 但请记住,
   # 将此标志设置为除默认值 *True* 以外的任何值都是安全问题,
   # 你可能需要尝试使用 ssh 传输
   pillar_gitfs_ssl_verify: True

   # `pillar_opts` 选项将 master 配置文件数据添加到
   # 在 pillar 中名为 "master" 的字典中.
   # 这用于在 master 配置文件中设置简单的配置, 然后可以在 minion 上使用.
   pillar_opts: False

   # `pillar_safe_render_error` 选项防止 master 传递 pillar 渲染错误给 minion.
   # 这是默认设置的, 因为错误可能包含模板数据, 它将提供它不应该拥有的 minion 信息,
   # 比如密码! 当设置为 *True* 时, 错误消息将只显示:
   #   Rendering SLS 'my.sls' failed. Please see master log for details.
   pillar_safe_render_error: True

   # `pillar_source_merging_strategy` 选项允许你配置不同源之间的合并策略.
   # 它接受五个值: none, recurse, aggregate, overwrite 或 smart:
   # - none 不会做任何合并;
   # - recurse 将递归地合并数据映射.
   # - aggregate 指示在源之间使用 `yamlex` 渲染器聚合元素.
   # - overwrite 将按照处理元素的顺序覆盖元素. 这是 2014.1 及更早版本的行为.
   # - smart 根据 "renderer" 设置猜测最佳策略, 并将其作为默认值.
   pillar_source_merging_strategy: smart

   # 通过聚合而不是替换列表, 递归地合并列表.
   pillar_merge_lists: False

   # 将此选项设置为 *True*, 以强制 pillarenv 在运行状态时与有效
   # saltenv 相同. 如果指定了 pillarenv, 此选项将被忽略.
   pillarenv_from_saltenv: False

   # 将此选项设置为 *True*, 以在尝试从 pillar 检索命名值失败时
   # 强制引发 "keyerror". 当此选项设置为 *False* 时,
   # 失败的尝试将返回空字符串. 默认值为 *False*.
   pillar_raise_on_missing: False

   # Git 外部的 Pillar (git_pillar) 配置选项
   #
   # 指定用于 git_pillar 的提供程序.
   # 必须是 *pygit2* 或 *gitpython*.
   # 如果未设置, 则将按相同的顺序尝试这两个版本,
   # 且安装了兼容版本的第一个将是所使用的提供程序.
   git_pillar_provider: pygit2

   # 如果所需的分支匹配这个值, 并且 `git_pillar` 配置中省略了环境,
   # 那么 git_pillar 远程的环境将是基础环境.
   git_pillar_base: master

   # 如果从 `git_pillar` 远程省略了这个分支, 那么将使用这个分支
   git_pillar_branch: master

   # `git_pillar` remote 使用的环境.
   # 这通常派生自分支 / 标记 ( 或每个远程的 env 参数 ),
   # 但如果设置了该参数, 将覆盖从分支 / 标记名称派生 env 的过程.
   git_pillar_env: ''

   # 相对于 `git_pillar` top 文件和 sls 文件所在存储库的根目录的路径.
   git_pillar_root: ''

   # 指定在联系远程存储库时是否忽略 SSL 证书错误
   git_pillar_ssl_verify: False

   # 当设置为 *False* 时, 如果 `git_pillar` remote 有一个更新 / 签出锁,
   # 并且写入该锁的 pid 没有在主机上运行, 则该锁文件将被自动清除, 并获得一个新锁.
   git_pillar_global_lock: True














