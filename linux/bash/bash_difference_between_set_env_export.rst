=========================
 set, env, export 的区别
=========================

set 显示 / 设置 shell 变量

  私有变量, 不同类的 shell 有不同的私有变量.
  bash, ksh, csh 每个 shell 私有变量都不一样;

env 显示 / 设置用户变量

export 显示 / 设置当前 **导出成用户变量** 的 shell 变量

.. code-block:: shell

   [root@centos8_2 ~]# aaa=bbb
                
   [root@centos8_2 ~]# echo $aaa
   bbb
   [root@centos8_2 ~]# set | grep aaa
   aaa=bbb
   [root@centos8_2 ~]# env | grep aaa
   [root@centos8_2 ~]# export | grep aaa # 返回空
                
   [root@centos8_2 ~]# export aaa
   [root@centos8_2 ~]# env | grep aaa
   aaa=bbb
   [root@centos8_2 ~]# export | grep aaa
   declare -x aaa="bbb"

linux 分 shell 变量 (set), 用户变量 (env). **shell 变量包含用户变量**.

export 是一种命令工具, 是显示那些通过 export 命令把 shell
变量中包含的用户变量导入给用户变量的那些变量
