.. _dig_basic:

DIG---DNS信息收集
======================================================================

常见用法
------------------------------------------------------------

- 查询域名对应的IP

  ``dig domain_name any [@dns_server_ip]``

  如: dig sina.com any @8.8.8.8

  地域对域名查询的影响: 多尝试从不同的 DNS 服务器查询;



- 反向查询

  主要用来做反垃圾邮件;

  dig -x <ip>


- 查询出 bind 的版本信息

  ``dig +noall +answer txt chaos VERSION.BIND @ns3.dnsv4.com``

  - +noall: 不显示所有的信息

  - +answer: 显示 ANSWER 部分的信息

- DNS 追踪

  ``dig +trace example.com``


进阶用法
------------------------------------------------------------

- 多重查询

``dig +qr www.isc.org any -x 127.0.0.1 isc.org ns +noqr``

  - 此命令包含三个查询:

    www.isc.org 的 any 查询;
    127.0.0.1 的反向查询;
    isc.org 的 ns 查询;

  - 全局查询选项 **+qr** ;
  - isc.org 的本地查询选项;

故多重查询语法可总结为: ::

  dig [查询选项(全局)] [选项] <域名|地址> [查询选项(本地)] [选项] <域名|地址> [查询选项(本地)]

- **-f** 指定文件进行查询 ::

    # Filename: test.dig
    www.baidu.com any
    www.163.com mx
    www.sina.com a

    root@kali:~# dig +noall +answer -f test.dig
    www.sina.com.           0       IN      CNAME   us.sina.com.cn.
    www.163.com.            0       IN      CNAME   www.163.com.lxdns.com.
    www.163.com.lxdns.com.  46      IN      A       221.230.143.101
    www.163.com.lxdns.com.  46      IN      A       61.147.226.161
    www.baidu.com.          0       IN      CNAME   www.a.shifen.com.
    www.a.shifen.com.       101     IN      A       180.97.33.107
    www.a.shifen.com.       101     IN      A       180.97.33.108
