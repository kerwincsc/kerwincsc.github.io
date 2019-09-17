=============================
 03 salt-minion 配置文件说明
=============================

主要配置设定
============

.. code-block:: shell
		
   # 用于管理 salt minion 的行为.
   # 除了 Salt master 服务器的位置之外, 注释掉但注释后有空行的值是默认值,
   # 不需要在配置中设置. 如果注释之后没有空行, 则将该值作为示例显示, 而不是默认值.

   ###### minion 可以包含哪些配置文件 ################################
   # 默认情况下, minion 将自动包含 ``minion.d/\*.conf`` 中的所有配置文件
   # ( minion.d 与 主要的 minion 配置文件位于同一目录中 )
   default_include: minion.d/*.conf

   # 设置 salt master 服务器的位置. 如果无法解析 master 服务器, 则 minion 将无法启动.
   master: salt

   ######  使用代理 ##################################################
   # 在处理请求时为 minion 设置 http 代理信息
   proxy_host:
   proxy_port:
   proxy_username:
   proxy_password:

   # 要绕过 HTTP 代理的主机列表. 除非配置了 proxy_host 等, 否则这个键什么也不做,
   # 它不支持任何类型的通配符.
   no_proxy: []
   

   ###### master 设置相关 ############################################
   # 如果在 "master" 设置中指定了多个 master,
   # 默认行为是始终按照列出的顺序连接它们. 如果 `random_master` 设置为 *True*,
   # 则在 minion 启动时将随机排列顺序.
   # 这对于分散许多执行 salt-call 请求的 minion ( 例如, 从cron作业 ) 的负载很有帮助.
   # 如果只列出一个主机, 则忽略此设置, 并将记录一个警告.
   random_master: False

   # 注意: 在 Salt 2019.2.0. 中已被废弃. 使用 'random_master' 来代替.
   master_shuffle: False

   # Minions 能够同时连接多个 masters( 所有的 master 都是 '热的' ),
   # 或者能配置成故障转移, 假如某个 master 变得不可用.
   # 通过将此值设置为 "str", 可以配置多个热主机.
   # 可以通过设置为 "failover" 来请求故障转移 master.
   # 你正在使用故障转移, 确保设置了 `master_alive_interval`.
   # 将 `master_type` 设置为 *disable*, 让你有一个正在运行的 minion ( 带有引擎和信标 )
   # 而没有 master 连接.
   master_type: str

   # 轮询间隔 ( 以秒为单位 ), 用于检查 master 服务器是否仍在.
   # 仅当上面的 `master_type` 是 *failover* 时才受重视.
   # 要完全禁用间隔, 请将值设置为 -1.
   # ( 这在具有大量 TCP 连接的计算机 ( 如负载均衡器 ) 上可能是必需的. ) 
   master_alive_interval: 30

   # 假设 minion 处于多 master 模式且 `master_type` 配置选项被设为 *failover*,
   # 将此项设置设置为 *True* 以便在第一个 master 设备重新联机时,
   # 强制 minion 故障转移回列表中的第一个 master.
   master_failback: False

   # 如果该 minion 处于多 master 模式, `master_type` 配置设置为 *failover*,
   # 并且启用了 `master_failback` 选项, 则 master 故障恢复间隔可以
   # 设置为 使用此间隔 ping 顶级 master 服务器, 以秒为单位.
   master_failback_interval: 0

   
   ###### 连接属性配置 ###############################################
   # 设定是否通过 ipv6 连接 master
   ipv6: False

   # 如果名称解析失败, 设置在尝试解析主机名之前等待的秒数.
   # 默认为 30 秒. 如果应关闭并且不重试, 则设置为零.
   retry_dns: 30

   # 设置在名称解析失败时尝试解析主机名的次数. 默认为 "无", 这将无限期尝试解决方案.
   retry_dns_count: 3

   # 设置 master 回复和身份验证服务器使用的端口
   master_port: 4506

   
   ###### salt 运行时的属性 ##########################################
   # 运行 salt 的用户
   user: root

   # 用户通过 sudo 运行 salt 远程执行命令.
   # 如果启用此选项, 则 sudo 将用于更改执行远程命令的活动用户.
   # 如果启用, 则需要允许用户通过 salt minion 配置为运行的用户的 sudoers 文件进行访问.
   # 最常见的选项是使用根用户.
   # 如果设置了此选项, 则用户选项也应设置为非根用户.
   # 如果从根用户迁移到非根用户, 则应清除该用户的缓存,
   # 并将该用户的 pki 目录更改为新用户的所有权.
   sudo_user: root

   # 指定守护进程 ID 文件的位置
   pidfile: /var/run/salt-minion.pid

   # 这些选项前面的根目录:  pki_dir, cachedir, log_file, sock_dir, pidfile
   root_dir: /

   # minion 配置文件的路径
   conf_file: /etc/salt/minion
   
   # 存储 pki 信息的目录
   pki_dir: /etc/salt/pki/minion

   # 显式声明这个 minion 要使用的 id, 如果向左注释,
   # id 将是 python 调用: socket.getfqdn() 返回的主机名,
   # 因为 salt 使用分离的 id, 可以在同一台计算机上运行多个 minions,
   # 但是使用不同的 id, 这对 salt 计算集群很有用.
   id:

   
   # 当在 minion 配置中没有静态定义 minion 的 id 时,
   # 将 minion id 缓存到文件中. 默认为 "真".
   # 此设置可防止在自动 minion ID 解析更改时出现潜在问题,
   # 这可能导致 minion 与 master 服务器失去连接.
   # 要关闭 minion id 缓存, 请将此配置设置为 *False*.
   minion_id_caching: True

   # 在主机名不存在的情况下, 将域追加到主机名.
   # 这对于 socket.getfqdn() 实际上不产生 fqdn 的系统 ( 例如, solaris ) 很有用.
   append_domain:
   # 暂时看不出来有什么作用, mark 下

   # 可以在这里指定这个 minion 的自定义静态粒度 (grain),
   # 并像所有其他粒度一样在 SLS 文件中使用.
   # 本例设置了 4 个自定义粒度, 其中 "roles" 粒度有两个值可以匹配.
   #grains:
   #  roles:
   #    - webserver
   #    - memcache
   #  deployment: datacenter4
   #  cabinet: 13
   #  cab_u: 14-15
   #
   # 缓存数据的去向.
   # 此数据可能包含敏感数据, 因此应受到相应保护.
   cachedir: /var/cache/salt/minion

   # 将 minion_id 追加到这些目录.
   # 帮助在同一台计算机上运行多个代理和 minion.
   # 列表中允许的元素: pki_dir, cachedir, extension_modules
   # 通常不需要, 除非在同一台计算机上运行多个代理和 / 或 minion
   # 默认为代理的是 ['cachedir'], []( 空列表 ) 为常规 minion
   append_minionid_config_dirs:

   # 启动时验证并设置配置目录的权限;
   verify_env: True

   # minion 可以本地缓存发送给它的作业返回的数据,
   # 这是跟踪 minion 执行的作业 ( 在 minion 一侧 ) 的好方法.
   # 默认情况下, 此功能被禁用, 若要启用, 请将缓存作业设置为 *True*
   cache_jobs: False

   # 设置用于持有 unix 套接字的目录
   sock_dir: /var/run/salt/minion

   # 当使用 lspci 和 / 或 dmidecode 填充 minion 的 grains 时,
   # minion 可能需要一段时间才能启动.
   # 如果您的 minion 不需要 GPU 硬件 grains, 请将此设置为 *False*
   enable_gpu_grains: True

   
   ####### 输出调整 ###################################################
   # 设置由 salt-call 命令使用的默认的输出器. 默认为 "nested".
   output: nested

   # 设置 `outputter_dirs` 选项, 来设置一个额外的目录列表来搜索 salt 输出器
   outputter_dirs: []

   # 默认情况下, 输出是彩色的. 把 `color` 值设为 *False* 来关闭彩色输出.
   color: True

   # 不要从嵌套的结果和状态输出中去掉彩色输出（ 默认为 *True*)
   strip_colors: False

   # 备份相对他们的初始目录的 'cachedir'/file_backup 目录下被 file.managed
   # 和 file.recurse 取代的且追加了时间戳的文件. 唯一有效的设置是 "minion".
   # 默认情况下禁用.
   #
   # 或者, 这可以为状态文件中的每个文件指定
   # /etc/ssh/sshd_config
   #   file.managed:
   #     - source: salt://ssh/sshd_config
   #     - backup: minion
   #
   backup_mode: minion

   # 当等待 master 接受 minion 的公钥时, salt将继续尝试重新连接, 直到成功.
   # 这是这些重新连接尝试之间的时间, 以秒为单位.
   acceptance_wait_time: 10

   # 如果此值不为零, 重新连接尝试之间的时间每次迭代将增加 `acceptance_wait_time`
   # 直至达到此最大值. 如果设置为零, 重新连接尝试之间的时间将保持不变.
   acceptance_wait_time_max: 0

   # 如果 master 拒绝了 minion 的公钥, 重试而不是退出.
   # 拒绝的密钥将与等待接受处理相同.
   rejected_retry: False

   # 当 master 密钥更改时, minion 将尝试重新验证自己以接收新的 master 密钥.
   # 在更大的环境中, 这可能会导致 master 上的 syn 泛滥,
   # 因为所有的 minion 都试图立即重新验证.
   # 要防止这种情况发生并让一个 minion 随机等待一段时间, 请使用此可选参数.
   # 等待时间将是介于 0 和定义值之间的随机秒数.
   random_reauth_delay: 60

   # 为了避免当许多 minion 同时启动时 master 服务器过载, 可以设置一个随机延迟,
   # 告诉 minion 在连接到 master 服务器之前等待. 这个值是一个随机数的秒数.
   # 例如, 将此值设置为 60, 将选择在 0 秒到 60 秒之间启动时延迟的随机秒数.
   # 设置为 "0" 将禁用此功能.
   random_startup_delay: 0

   # 当等待 master 接受 minion 的公钥时, salt 将继续尝试重新连接, 直到成功.
   # 这是每次尝试的超时值 ( 秒 ). 此超时过期后, 在重试之前 minion
   # 将等待 `acceptance_wait_time`, 除非你的 master 承受着异常沉重的负担,
   # 否则这应该是默认的.
   auth_timeout: 60

   # 尝试验证时可接受的连续 SaltReqTimeoutError 数.
   auth_tries: 7

   # 在放弃前, 尝试连接到 master 的次数.
   # 设为 -1 代表无限次尝试. 这允许 master 服务器有停机时间, 并且当它重新启动时,
   # minion 可以重新连接到它. 在 "故障转移" 模式下, 它是每组 master 服务器的尝试次数.
   # 在此模式下, 它每次尝试将循环遍历 master 列表.
   #
   # 这不同于 `auth_tries` 因为 `auth_tries` 尝试对单台 master 重新进行身份验证.
   # `auth_tries` 的前提是您可以连接到 master, 但不能从它获得授权.
   # 在给定的尝试中, `master_tries` 仍然会循环遍历所有 master,
   # 因此, 如果您希望 master(s) 偶尔停机, 这是适当的.
   master_tries: 1

   # 在 `ping_interval` 期间如果因为 SaltReqtimeoutError 身份验证失败,
   # 将会引发子 minion 进程重启.
   auth_safemode: False

   # ping Master 以确保连接存活 ( 按分钟算 ).
   ping_interval: 0

   # 如果 master 服务器更改了 IP 地址, 则自动恢复 minions. (DDNS)
   #    auth_tries: 10
   #    auth_safemode: False
   #    ping_interval: 2
   #
   # 直到 ping 失败, Minions 才知道 master 消失了.
   # 在 ping 失败之后, minion 将尝试进行身份验证并且可能会失败并导致重新启动.
   # 当 minion 重启时, 将解析 master IP 并尝试去重连.

   # 如果你对 syn-floods 没有任何问题, 请不要使用下面描述的三个 recon_* 设置,
   # 保留默认设置就好.
   #
   # 如果套接字未连接 ( 比如, 如果 master 进程重新启动 ),
   # 绑定到 master 发布接口的 ZeroMQ pull-socket 将尝试立刻重新连接.
   # 在大型设置中, 这将使所有的 minion 立即重新连接,
   # 这可能会淹没 master 服务器 ( ZeroMQ 默认值通常是 100 毫秒的延迟 ).
   # 为了防止这种情况发生, 可使用这三种 recon_* 设置.
   # recon_default: 套接字在尝试重新连接到 master 服务器之前应等待的时间间隔
   #                (毫秒, 1000ms = 1 second)
   # recon_max: 套接字应该等待的最大时间. 等待时间的每个间隔都是通过将上一个时间加倍来计算的
   #            如果达到 recon_max, 则在 recon_default 时再次启动. 简短的例子:
   #
   #            reconnect 1: 套接字将等待 `recon_default` 毫秒
   #            reconnect 2: `recon_default` * 2
   #            reconnect 3: `recon_default` * 2 * 2
   #            reconnect 4: 上一个值 * 2
   #            reconnect 5: 上一个值 * 2
   #            reconnect x: 如果值 >= recon_max, 它再次以 `recon_default` 开始
   #
   # recon_randomize:
   #     在 minion 启动时生成一个随机地等待时间.
   #     此等待时间会是一个在 `recon_default` 和 `recon_default + recon_max` 之间的随机值.
   #     让所有的 minion 以相同的 `recon_default` 和
   #     `recon_max` 值重新连接有点挫败了改变这些设置的目的.
   #     如果所有的 minions 有相同的值并且你的设置相当大 ( 几千台 minions ),
   #     它们仍然会淹没 master.  期望的行为是让所有的 minion 在时间范围内尝试重新连接.
   #
   # 如何使用这些设置的示例. 目标:  断开连接后, 让所有的 minion 在 60 秒内重新连接.
   # recon_default: 1000
   # recon_max: 59000
   # recon_randomize: True
   #
   # 每个 minion 将有一个在 `recon_default` 和 `recon_default + recon_max` 间的随机值,
   # 在此例中意味着, 在 1000ms 和 60000ms ( 或者说在 1s 和 60s 之间) 之间.
   # 生成的随机值将会在每次尝试重连后成倍. 假设生成的随机值是 11 秒 (11000ms).
   # reconnect 1: wait 11 seconds
   # reconnect 2: wait 22 seconds # * 2
   # reconnect 3: wait 33 seconds # * 3
   # reconnect 4: wait 44 seconds # * 4
   # reconnect 5: wait 55 seconds # * 5
   # reconnect 6: 等待时间超出了 60s ( recon_default + recon_max )
   # reconnect 7: wait 11 seconds
   # reconnect 8: wait 22 seconds
   # reconnect 9: wait 33 seconds
   # reconnect x: etc.
   #
   # 在一个拥有约 600000 个主机的设置中, 这些设置将平均每秒重新连接约 100 次,
   # 所有主机将在 60 秒内重新连接.
   # recon_default: 100
   # recon_max: 5000
   # recon_randomize: False
   #
   #
   # `loop_interval` 设置了在评估调度程序和运行清理任务之间 minion 等待的时间 ( 秒 ).
   # 这在 minion 调度程序中默认为 1 秒.
   loop_interval: 1

   # 有些安装选择在缓存或返回程序中启动所有作业返回, 而放弃将结果发送回 master 服务器.
   # 在这个工作流中, 作业通常使用 Salt CLI 中的 --async 执行,
   # 然后通过检查 minion 或任何配置的返回者上的作业缓存来评估结果.
   # 警告: 设置为 *False* 将 **禁止** 返回给 master.
   pub_ret: True

   ###### grains 设置 ################################################
   # 使用此选项可以合并而不是重写 grains .这允许自定义 grains 定义字典 grains 的不同子值.
   # 默认情况下, 此功能处于禁用状态, 将 `grains_deep_merge` 设置为 *True* 可以启用.
   grains_deep_merge: False

   # `grains_refresh_every` 设置允许 minion 定期检查自己的 grains, 看看它们是否发生了变化,
   # 如果发生了变化, 就将新的 grains 告知 master.
   # 此操作的成本适中, 因此应注意不要将此值设置得太低.
   #
   # 注意: 此值以 *分钟* 进行表达
   #
   # 默认值为10分钟是合理的
   #
   # 如果此值被设置为 0, 此项检查将被禁止.
   grains_refresh_every: 1

   # 在 minion 上缓存 grains. 默认禁止.
   grains_cache: False

   # 在 minion 上缓存渲染过的 pillar 数据. 默认禁止.
   # 这可以会导致 'cachedir'/pillar 包含敏感数据, 应该相应地进行保护.
   minion_pillar_cache: False

   # grains 缓存过期时间, 以秒为单位.
   # 如果缓存文件早于此秒数, 则将转储 grains 缓存并用新数据完全重新填充.
   # 默认为 5 分钟. 如果未启用 `grains_cache`, 则不会有任何效果.
   grains_cache_expiration: 300

   ###### mine 设置相关 ##############################################
   # 确定 Salt minion 是否应运行计划的 mine 更新.
   # 默认为 *True*. 设置为 *False* 以禁用计划的 mine 更新
   # ( 这实际上并没有将 mine 更新功能添加到 minion 的计划程序中 )
   mine_enabled: True

   # 确定计划的 mine 更新是否应附带作业缓存的作业返回.
   # 默认为 *False*. 设置为 *True* 以将作业返回包含在作业缓存中以进行 mine 更新.
   mine_return_job: False

   # 可以通过 mine 工具运行的示例函数, 默认情况下不建立任何 mine 函数.
   # 注意这些也可以在 minion 的 piilar 里定义.
   mine_functions:
     test.ping: []
     network.ip_addrs:
       interface: eth0
       cidr: '10.0.0.0/8'
       
   # mine 更新间隔的分钟数
   mine_interval: 60

   # Windows 平台缺少 POSIX IPC, 必须依赖较慢的基于 TCP 的进程间通信.
   # 在此类系统上, 将 `ipc_mode` 置为 *tcp*.
   ipc_mode: ipc

   # 当 ipc_mode 模式设置为 *tcp* 时, 覆盖 minion 使用的默认 tcp 端口.
   tcp_pub_port: 4510
   tcp_pull_port: 4511

   # 传递非常大的事件会导致 minion 消耗大量内存.
   # 此值调整 minion 事件总线上允许的最大消息大小. 该值以字节表示.
   max_event_size: 1048576

   # 当一个 minion 启动时, 它会在事件总线上发送一个通知,
   # 并带有如下标记: `salt/minion/<minion_id>/start`.
   # 出于历史原因, minion 还发送了一个类似的事件, 带有这样的事件标签: `minion_start`.
   # 当有许多 minion 时, 这种复制会导致事件总线上出现大量混乱.
   # 在 minion 配置中设置 `enable_legacy_startup_events: False`,
   # 以确保只发送 `salt/minion/<minion_id>/start` 事件.
   # 从 "Sodium" 开始, 这个选项默认为 *False*.
   enable_legacy_startup_events: True

   # 若要在连接 / 断开连接时检测失败的 master 节点和激发事件,
   # 请将 `master_alive_interval` 设置为轮询 master 节点连接事件的秒数.
   master_alive_interval: 30

   # minion 可以包含来自其他文件的配置. 要启用此功能, 请将路径列表传递到此选项.
   # 路径可以是相对的, 也可以是绝对的;
   # 如果是相对的, 则认为它们相对于主 minion 配置文件所在的目录 ( 此文件 ).
   # 路径可以使用 shell 样式的全局化.
   # 如果传递给该选项的路径不匹配任何文件, 则 minion 将记录一条警告消息.
   #
   # 从其它路径包含一个配置文件
   # include: /etc/salt/extra_config
   #
   # 从几个文件和目录包含配置
   #include:
   #  - /etc/salt/extra_config
   #  - /etc/roles/webserver

   # syndic minion 可以使用 `syndic_finger` 配置,
   # 通过更高级别 master 的密钥指纹来验证它正在与正确的主机通话.
   syndic_findger: ''
