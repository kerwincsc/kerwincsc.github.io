==========================
 k8s 搭建过程中的常见问题
==========================

- iptables-restore: invalid option

  具体报错为:

  .. code-block:: shell
		  
     proxier.go:1667] Failed to execute iptables-restore: exit status 1 (iptables-restore: invalid option -- '5'

  尝试按装低于当前系统版本自带的 iptables, 比如 **iptables-1.4.7-19.el6**,
  去 `rpmfind`_ 下载, 或者去官方网站, 但是可能要编译.





.. _rpmfind: http://rpmfind.net/
