================
 pip
================

国内源
======

新版 ubuntu 要求使用 https 源, 要注意;

+--------------+------------------------------------------+
| 清华         | https://pypi.tuna.tsinghua.edu.cn/simple |
+--------------+------------------------------------------+
| 阿里云       | http://mirrors.aliyun.com/pypi/simple/   |
+--------------+------------------------------------------+
| 中国科技大学 | https://pypi.mirrors.ustc.edu.cn/simple/ |
+--------------+------------------------------------------+
| 华中理工大学 | http://pypi.hustunique.com/ 无法使用     |
+--------------+------------------------------------------+
| 山东理工大学 | http://pypi.sdutlinux.org/  无法使用     |
+--------------+------------------------------------------+
| 豆瓣         | http://pypi.douban.com/simple/           |
+--------------+------------------------------------------+

临时使用
========

在使用pip的时候加参数 **-i** https://pypi.tuna.tsinghua.edu.cn/simple

例如: pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pyspider
这样就会从清华这边的镜像去安装 pyspider 库

永久修改
========

Linux下，修改 ~/.pip/pip.conf ( 没有就创建一个文件夹及文件. 文件夹要加 ".")

::

   [global]
   index-url = https://pypi.tuna.tsinghua.edu.cn/simple

   [install]
   trusted-host=mirrors.aliyun.com

windows 下, 直接在 user 目录中创建一个 pip 目录, 如: C:\\Users\\xx\\pip,
新建文件 pip.ini, 内容同上;
