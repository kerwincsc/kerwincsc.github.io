Heartbeat 部署
======================================================================

包安装顺序: Reusable-Cluster -> Cluster-glue -> Heartbeat

源码安装 Heartbeat 时常见错误

- bootstrap 期间

  - 未找到 autoconf, automake, libtool

    ``yum install autoconf automake libtool libtool-*-devel -y``


  - configure 时遇到的错误;

    - **configure: error: Core development headers were not found**

      安装 cluster glue 后, 再出现同样的错误, 使用 ``./ConfigureMe configure``

  - make 时遇到错误:

    - fatal error: replace_uuid.h: No such file or directory

      执行 ``yum install -y libuuid-devel`` 解决

    - gmake[1]: --xinclude: Command not found

      


- 安装 cluster glue

  - 配置检查

    ``yum install glib2-devel libxml2-devel bzip2-devel -y``


  - cluster glue 编译时常见错误

    - ./.libs/libplumb.so: undefined reference to 'uuid_parse'

      configure 时加上: ./configure LIBS='/lib64/libuuid.so.1', 配置 Resource Agents 时,
      也需要加上;

      32bit: LIBS='/lib/libuuid.so.1'

      64bit: LIBS='/lib64/libuuid.so.1'

    - gmake[2]: a2x: Command not found

      ``yum install asciidoc -y``

- 启动 heartbeat 后

  - 网卡没有自动绑定

    可能是 resource.d 里的文件路径配置有问题;--> 配置调整后未解决
