RECON-NG
======================================================================

RECON: 侦察, reconnaissance的缩略形式

- 全特性的 web 侦察框架, web 信息搜索框架
- 基于 Python 开发
- 命令格式与 msf [#]_ 一致
- 使用方法

  - 模块
  - 数据库
  - 输出报告

- 全局选项

  - 支持代理 set PROXY 127.0.0.1:8087
  - USER-AGENT
  - Keys 对应搜索引擎的 API

    Usage: keys add <name> <value>

  - Workspaces 不同搜索信息的隔离
  - Snapshot


- 一般流程

  - DNS 查询

    搜索指定模块来完成 DNS 查询

    - Google
    - Baidu
    - Bing
    - Yahoo
    - Brute force 暴力破解

      recon-ng 中有此模块, 搜索可得

  - 解析 IP 地址 (查询数据库)

    搜索解析模块 *resolve*, 如 recon/hosts-hosts/resolve;

    可以通过配置 SOURCE 解析指定范围的主机名,
    比如 *query select host from hosts where host like '%sina.com.cn%'*;
    不能使用 *select ** , 因为解析域名时, 只需要 host 这一列, 不需要其它列,
    *select ** 将返回一整条满足条件的记录, 模块将无法得知需要解析哪一列;

  - 联系人
  - 报告

    搜索报告模块 *report*

  - API


- 模块简易使用流程

  - 使用 *search* 搜索需要模块名;
  - ``use <module_name>``
  - 进入模块的提示符后, 建议以下流程:

    - show options 该模块下, 可指定的变量参数;
    - show info    show options 的详细版;

  - 运行模块 ``run``

    如果用 google 等天朝无法直接访问的网站进行搜索, 需要配置代理;


.. rubric:: Footnotes

.. [#] msf: MetaSploit Framework
