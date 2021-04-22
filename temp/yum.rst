==============
 yum 问题收集
==============

- 问题
  
  - 订阅插件提示: This system is not registered with an entitlement server. You can use subscription-manager to

  - 解决办法

    这个 Red Hat Subscription Manager 订阅管理器,
    它会让你一直register, 禁用就好.
    
    脚本文件: /usr/lib/yum-plugins/subscription-manager.py
    
    配置文件: /etc/yum/pluginconf.d/subscription-manager.conf
    
    调用了脚本 /usr/share/rhsm/repolib.py
    
    去重写或者更新 /etc/yum.repos.d/redhat.repo 文件
    
    每次 yum 调用 ( 不禁掉 plugins 的情况下 ), 都会更新此文件
    
    因此, 为了不冲突, 可以如下操作:
    停止掉该插件的使用, 在配置文件中把 **enable=0** 即可

    .. code-block:: shell

       [root@Oradb1 pluginconf.d]# vim /etc/yum/pluginconf.d/subscription-manager.conf
       [main]
       enabled=0 # 由 1 改为 0;
