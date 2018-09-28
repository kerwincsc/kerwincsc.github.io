未整理的 zabbix 小提示
======================================================================

Detect operating system [zabbix]
------------------------------------------------------------

zabbix 默认会有3个script功能, 分别是Detect operating system, ping, traceroute, 都比较好用.
默认安装完毕需要做一些修改才能正常使用;

1. traceroute, 默认的 path 不对, which traceroute, 然后把正确的信息填上去就行了;

2. Detect operating system

   command 是sudo /usr/bin/nmap -O {HOST.CONN} 2>&1 

   这个没错，sudo 上设置一下就好了

   visudo 

   **zabbix ALL=(root) NOPASSWD: /usr/bin/nmap** 实际上这步做完就可以了,
   至少 zabbix 3.0 centos7 上是OK的;

   完了你还得把 #Defaults requiretty 注释掉, 就ok了;
   同样的sudo规则, 还可以在 zabbix_agentd 的自定义监控上面;


Zabbix Discovery 网络发现
------------------------------------------------------------

适用场景: 本地快速添加

- 配置自动发现规则

  #. 指定 IP 范围
  #. 指定延时: 延时过低可能不会触发发现规则, 比如我遇到过设为 60s, 就不起作用, 改为 120s 就可以了;
  #. 指定检查项
  #. 指定设备唯一性规则: 基于 IP / 基于

主动注册
------------------------------------------------------------

适用场景: 适用于云环境

zabbix_agent.log 中 **no active checks on server [ip:port]: host [hostname] not found** 
只是为了提醒你, 当前你设置的 hostname 在 zabbix-server 上是独一无二的.
正如 *主动注册* 中所描述的那样: Hostname 必须是独一无二的, 大小写敏感的;
