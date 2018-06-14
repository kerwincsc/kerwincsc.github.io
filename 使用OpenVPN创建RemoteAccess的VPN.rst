======================================================================
使用OpenVPN创建RemoteAccess的VPN
======================================================================

运维场景
------------------------------------------------------------

为经常不在办公室的驻场人员或远程办公人员提供访问服务器资源或者办公网络
资源的通道;

在此场景下, 远程访问者一般没有公网IP, 他们使用内网地址通过防火墙设备进行
NAT转换后连接互连网;

物理架构
------------------------------------------------------------

条件有限, 我只能用三台虚拟机来完成整个实验, 架构图如下:

.. image:: RemoteAccessVPN.svg

操作步骤
------------------------------------------------------------

.. tips::
   最新版本的 openvpn , 已经将 easy-rsa 单独做成一个项目了, 所以如果要使用
   脚本辅助生成和管理证书, 那么要再单独下载, 下载地址直接在 github 中搜索
   相关项目;

#. Server1 上生成 *CA证书* , *服务器证书* , *客户端证书* ;

   #. 初始化 ``./easy-rsa init-pki`` , 将会在当前目录自成 *pki* 目录;

   #. 生成CA证书 ``./easyrsa build-ca`` , 将会在 pki 目录中生成文件 ca.crt ; ::

   #. 生成 openvpn 服务器证书和私钥并用 CA 证书签名

   #. 生成 openvpn 客户端的证书和私钥并用 CA 证书签名

   #. 在 Server1上配置 OpenVPN , 配置文件为 server.conf , 内容如下 ::

	port 1194    # 使用1194端口进行监听
	proto udp    # 使用udp协议
	dev tun      # 使用IP路由模式

	ca <path>/ca.crt             # 指定CA证书的位置
	cert <path>/vpnserver.crt    # 指定服务器端证书位置
	key <path>/vpnserver.key     # 指定服务器端私钥位置
	# 此文件未生成, 请先生成 ./easyrsa gen-dh, 花较长时间;
	dh <path>/dh1024.pem         # 使用Diffie-Hellman算法进行加密密钥计算

	server 10.102.202.0 255.255.255.0  #客户端连接上VPN后从此网段分配隧道IP
	client-config-dir /etc/openvpn/ccd #使用此目录对各个VPN客户端进行细粒度控制
	route 172.31.225.0 255.255.255.0   #配置服务器增加一条到客户端网络的路由

        # 每10秒发送保活, 120秒内未收到保活信息时, 向OpenVPN进程发送SIGUSR1信号
	keepalive 10 120
	# 在TLS控制通道的通信协议上增加一层
	# HMAC(Hash-based Message Autheratication Code) 防止 DDOS攻击
	# ta.key 可以由 openvpn --gen-key --secret ta.key 生成
	tls-auth <path>/ta.key 
	comp-lzo        # 启用压缩
	max-clients 100 # 最大用户数
	user nobody     # 执行OpenVPN进程的用户
	group nobody    # 执行OpenVPN进程的组
	persist-key     # 收到信号 SIGUSR1 时不重新读取 key 文件
	persist-tun     # 收到信号 SIGUSR1 时不关闭 tun 虚拟网口和重新打开

	# 创建并修改权限使用nobody可以读写 /var/log/openvpn
	status /var/log/openvpn/status.log    # 指定状态日志位置
	log-append /var/log/openvpn/openvpn.log # 指定运行日志位置
	verb 4      # 设置日志级别为一般级别, 会记录正常连接信息和报错

   #. /etc/openvpn/ccd 下的文件 kerwin-client 的内容 ::

	ifconfig-push 10.102.202.9 10.102.202.10    # 指定客户端的IP为10.102.202.9
        iroute 172.31.225.0 255.255.255.0           # 增加一条内部路由
        push "route 172.31.225.0 255.255.255.0"     # 把该路由推送到客户端执行
        这里的配置我不太明白, 暂时忽略;

.. note::
   以下项目必须要一致: cipher, ca, dev, proto, comp-lzo

   服务端配置 ``tls-auth <path>/ta.key 0`` 且客户端配置 ``tls-auth <path>./ta.key 1``
   如果此项设置不匹配, 则会出现 **HMAC authentication failed**
