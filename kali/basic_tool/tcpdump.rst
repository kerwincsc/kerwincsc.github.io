TCPDUMP
======================================================================

- No-GUI
- 一般默认安装

抓包
------------------------------------------------------------

- 抓包

  - 默认只抓68个字节
  - tcpdump -i eth0 -s 0 -w file.pcap

    **-s 0** size 0 包有多大就抓多大
  - tcpdump -i eth0 port 22

- 读取抓包文件

  - tcpdump -r file.pcap

    **-A** 以 ASCII 解码读取到的文件

    **-X** 以 16 进制解码

筛选
------------------------------------------------------------

- tcpdump -n -r http.pcap | awk '{print $3}' | sort -u
- tcpdump -n src host 145.254.160.237 -r http.pcap
- tcpdump -n port 53 -r http.pcap
- tcpdump -nX port 80 -r http.pcap

高级筛选
------------------------------------------------------------

- tcpdump -A -n 'tcp[13] = 24' -r http.pcap

  筛选出 tcp 包的第 13 号字节等于 24 的包


