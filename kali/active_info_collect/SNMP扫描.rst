SNMP 扫描
======================================================================

- snmp

  snmp --> udp 服务端: 161 客户端: 162

  dhcp server: 67 client: 68

  - 信息金矿
  - 经常被错误配置
  - public / private / manager

    配置 private, 可修改配置

- MIB Tree

  - SNMP Management Information Base (MIB)
  - 树形的网络设备管理功能数据库
  - 1.3.6.1.4.1.77.1.2.25

    客户端导入标准的 MIB 库, 然后就可以使用上面的这个序列查特定的数据;

- onesixtyone

  161 命令

  - onesixtyone 172.31.225.72 public

    如果目标主机修改了默认的 community, 可以考虑使用下面的方式,
    利用 community 字典来逐一尝试;
    
  - onesixtyone -c /usr/share/doc/onesixtyone/dict.txt -i host.txt -o my.log -w 100

    /usr/share/doc/onesixtyone/dict.txt 默认自带了一个 community 的字典;

    -w 是每隔多个毫秒去发一个包 ;

    -i 跟主机列表 ;

- snmpwalk

  - snmpwalk 172.31.225.72 -c public -v 2c

    -c community ;

    -v 版本(包括 2c-->windows) ;

  - snmpwalk 172.31.225.72 -c public -v 2c <OID>

    比如目标系统的硬件架构的序列: iso.3.6.1.2.1.1.1.0, 则它的 OID 应该是把 iso 改为 1 的全部;

    如下所示:

    snmpwalk 172.31.225.72 -c public -v 2c 1.3.6.1.2.1.1.1.0

- snmp-check

  这个命令查看更直观;

  此命令在教程中的 1.8 版本是 snmpcheck, 1.9 版本后就成了 snmp-check, 用法也有所改变;

  - snmp-check 172.31.225.72 -c public

    教程中, 此处用了 -t 参数, 但在 1.9 版本中, -t 参数意义被更改, --timeout
