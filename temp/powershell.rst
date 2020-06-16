Powershell脚本5种执行权限介绍
=============================

#. Restricted

   默认的设置, 不允许任何脚本运行;



#. AllSigned

   只能运行经过数字证书签名的脚本;



#. RemoteSigned

   运行本地的脚本不需要数字签名, 但是运行从网络上下载的脚本就必须要有数字签名;



#. Unrestricted

   允许所有的脚本运行;



#. Undefined

   在 Windows10 下这是默认的值, 表示未设置任何执行权限.
   这个值一般是 **用来删除执行策略** 的;

   要删除特定范围的执行策略, 请将执行策略设置为 Undefined;


- 问: 如何设置 Powershell 脚本执行权限?

  答: 先以管理员身份打开 Powershell,
  再执行命令: "set-executionpolicy remotesigned";
  后面的值可以随意更改成上面任意的一种;
