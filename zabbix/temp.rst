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
