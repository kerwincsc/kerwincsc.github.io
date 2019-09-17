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

   # 设置由 salt-call 命令使用的默认的输出器. 默认为 "nested".
   output: nested

   # 设置 `outputter_dirs` 选项, 来设置一个额外的目录列表来搜索 salt 输出器
   outputter_dirs: []

   # 默认情况下, 输出是彩色的. 把 `color` 值设为 *False* 来关闭彩色输出.
   color: True

   # 不要从嵌套的结果和状态输出中去掉彩色输出（ 默认为 *True*)
   strip_colors: False

   # 在 "cachedir"/file_backup 下相对于原始位置替换为 file.managed
   # 和 file.recurse 并附加时间戳的备份文件。唯一有效的设置是“minion”。默认情况下禁用。


