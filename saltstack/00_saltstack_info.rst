====================
 00 SaltStatck 说明
====================

安装
====

`参考官网`_

1. 安装 saltstack 的库和密钥

   .. code-block:: shell

      sudo yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest.el7.noarch.rpm

2. 清除过期的缓存

   .. code-block:: shell

      sudo yum clean expire-cache

3. 安装 salt-minion, salt-master, 以及其它 Salt 组件

   .. code-block:: shell

      sudo yum install salt-master
      sudo yum install salt-minion
      # 在不安装 salt-minion 的情况下
      # 直接使用 salt-ssh 控制客户端;
      sudo yum install salt-ssh
      # salt-syndic 类似于 zabbix-proxy, 是代理模块
      sudo yum install salt-syndic
      sudo yum install salt-cloud
      sudo yum install salt-api


.. _`参考官网`: https://repo.saltstack.com/index.html#rhel
