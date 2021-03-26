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
       # g = git 不生效
       st = status
       lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Cre
       set %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

配置文件的优先级
================

项目本地的 **.git/config** ---> 用 ``git config`` 读写, 优先于
用户全局的 **.gitconfig** ---> 用 ``git config --global``, 优先于
系统范围的 **/etc/gitconfig** ---> 用 ``git config --system``;
