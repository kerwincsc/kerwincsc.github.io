==============
 git 常见问题
==============

我为什么要自己编译最新版本的 git,
因为 **Magit requires Git >= 2.2.0, you are using 1.8.3**;

编译问题
========

- 编译安装git提示：Can't locate ExtUtils/MakeMaker.pm

  情景: 编译 git-2.9.5 时遇到;

  解决: ``yum install perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker``

克隆指定分支
============

::

   git clone -b <branch_name> <url>
