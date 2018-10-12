SMB扫描
======================================================================

- Server Message Block 协议

  - 微软历史上出现安全问题最多的协议
  - 实现复杂
  - 默认开放
  - 文件共享
  - 空会话未身份认证访问 (SMB1.0) <- 知名的漏洞

    - 密码策略
    - 用户名
    - 组名
    - 机器名
    - 用户, 组 SID

- 扫描命令

  - nmap

    - nmap -v -p 139,445 172.31.225.1-20

      一般情况下, windows 机器默认会开放 smb 服务, 也就 139,445 端口是默认打开的机器
      很可能就是 windows 机器;

      但是如果 Linux 系统也安装了 samba 服务, 默认这两个端口也是打开的;
      如果根据此端口是否打开来判断系统类别, 肯定是不够准确的;

    - nmap 172.31.225.72 -p 139,445 --script=smb-os-discovery.nse

      使用 nmap 脚本进行系统识别

      ::

	 Starting Nmap 7.70 ( https://nmap.org ) at 2018-10-12 14:42 CST
	 Nmap scan report for 172.31.225.72
	 Host is up (0.00020s latency).
	 
	 PORT    STATE SERVICE
	 139/tcp open  netbios-ssn
	 445/tcp open  microsoft-ds
	 MAC Address: 1C:1B:0D:24:66:AD (Giga-byte Technology)
	 
	 Host script results:
	 | smb-os-discovery: 
	 |   OS: Windows 10 Pro 17134 (Windows 10 Pro 6.3)
	 |   OS CPE: cpe:/o:microsoft:windows_10::-
	 |   Computer name: DESKTOP-MBOHD2G
	 |   NetBIOS computer name: DESKTOP-MBOHD2G\x00
	 |   Workgroup: WORKGROUP\x00
	 |_  System time: 2018-10-12T14:42:44+08:00
	 
	 Nmap done: 1 IP address (1 host up) scanned in 7.25 seconds
	 
    - nmap -v -p 139,445 --script=smb-check-vulns --script-args=unsafe=1 172.31.225.72

      使用 *unsafe=1* 可能会造成系统出问题, 且扫描速度慢;

      使用 *safe=1* 速度快, 不会造成破坏性后果;

      如果有防火墙, 致使目标主机看起来是不在线的, 可以加 **-Pn** ;

      由于从NMAP 6.49beta6开始, **smb-check-vulns脚本被取消了**;
      它被分为smb-vuln-conficker, smb-vuln-cve2009-3103, smb-vuln-ms06-025, smb-vuln-ms07-029,
      smb-vuln-regsvc-dos, smb-vuln-ms08-067 这六个脚本, 用户根据需要选择对应的脚本;
      如果不确定执行哪一个, 可以使用 ``smb-vuln-*`` 来指定所有的脚本文件;

  -  nbtscan

     如果防火墙策略不太严格, 可以跨网段扫描机器;

     - nbtscan -r 192.168.60.0/24

       *-r* 使用本地端口137进行扫描, 兼容性比较好, 可以扫描早期系统;

  - enum4linux
    
    结果十分详细

    - enum4linux -a 172.31.225.72

      只能跟具体地址, 不支持掩码方式的IP地址

      *-a*  做所有的简单枚举;
