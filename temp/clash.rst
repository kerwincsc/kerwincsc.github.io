=========================
 命令行 clash 代理的配置
=========================

#. 执行以下代码下载并配置 Clash_for_linux_amd64.
   如果不是 amd64 请在 `此处`_ 下载对应版本;

   #. 下载客户端

      .. code-block:: shell

	 mkdir /opt/wocclash && cd /opt/wocclash
	 wget https://www.lolxiu.vip/woc/clash_linux/clash && chmod +x clash
	 wget https://www.lolxiu.vip/woc/clash_linux/Country.mmdb

   #. 下载配置文件

      .. code-block:: shell

	 wget -O config.yaml https://api.lolxiu.vip/link/YSvFnWSf3VE05I0C?clash=1
	 
   #. 设置为系统服务

      .. code-block:: shell

	 cat > /usr/lib/systemd/system/clash.service <<'EOF'
	 [Unit]
	 Description=clash
	 [Service]
	 TimeoutStartSec=0
	 ExecStart=/opt/wocclash/clash -d /opt/wocclash
	 [Install]
	 WantedBy=multi-user.target
	 EOF

   卧槽云在后续可能增删节点或变更配置,
   如遇配置问题请重新 **下载配置文件** 进行更新

#. 操作 Clash
   
   - 启动Clash: systemctl start clash
   - 关闭Clash: systemctl stop clash
   - 查看状态: systemctl status clash
   - 设置开机自启: systemctl enable clash
   - 取消开机自启: systemctl disable clash

   设置Clash:

       本地浏览器访问 ``clash.razord.top/#/settings`` 进行切换节点,
       测延迟等操作;
       如果是远程服务器请确认开放 9090 端口:
       Host: Your_IP/127.0.0.1, Port: 9090

#. 终端设置

   - 系统代理

     .. code-block:: shell

	export ALL_PROXY="socks5://127.0.0.1:7891"
	export all_proxy="socks5://127.0.0.1:7891"
	# 或
	export ALL_PROXY="socks5://127.0.0.1:7891" && export all_proxy="socks5://127.0.0.1:7891"

     检查代理是否设置成功: ``curl https://ip.gs``

   - 取消代理

     .. code-block:: shell

	unset ALL_PROXY
	unset all_proxy
	# 或
	unset ALL_PROXY && unset all_proxy
   
	 
.. _此处: https://github.com/Dreamacro/clash
