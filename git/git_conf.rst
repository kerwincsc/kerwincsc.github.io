==============
 git 配置文件
==============

.. code-block:: shell

   [user]
       email = kerwincsc@foxmail.com
       name = kerwin
   [push]
       default = matching
   [core]
       # 解决中文显示 16 进制的问题;
       quotepath = false
       editor = emacsclient -nw
   [alias]
       co = checkout
       br = branch
       ci = commit
       g = git
       st = status
