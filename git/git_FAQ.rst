==============
 git 常见问题
==============

编译问题
========

- 编译安装git提示：Can't locate ExtUtils/MakeMaker.pm

  情景: 编译 git-2.9.5 时遇到;

  解决: ``yum install perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker``
