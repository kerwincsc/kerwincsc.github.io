===============
 salt-ssh 说明
===============

- 在安装部署 SaltStack 的时候, 需要安装 salt 客户端,
  还要与 salt 服务端进行认证才能互相通信;

- 使用 salt-ssh 的方式就不需要安装 salt 客户端, 也不需要做认证,
  是 master 基于 ssh 去连接 minion 的;

- Master 需要生成密钥以备使用;

配置
====

.. code-block:: shell

   [root@localhost ~]$ cat /etc/salt/roster    # 编辑 salt-ssh 配置文件
   minion01:                                   # 指定客户端主机名
   host: 192.168.119.140                       # 指定客户端IP
   user: root                                  # 指定登录用户
   passwd: root                                # 指定登录密码
   port: 22                                    # 指定ssh端口
   sudo: True

   # 使用 salt-ssh 远程执行 'w' 命令, -r 表示直接使用 shell 命令
   # --key-depoly 表示第一次执行的时候会把 master 上的公钥推送到minion上,
   # 这样我们就可以把 /etc/salt/roster 里的密码删掉了
   [root@localhost ~]$ salt-ssh --key-deploy '*' -r 'w' 
   # 把密码去掉再试一次
   [root@localhost ~]$ vim /etc/salt/roster
   # 继续再跑一次, 不需要再加 --key-depoly
   [root@localhost ~]$ salt-ssh ‘*‘ -r 
