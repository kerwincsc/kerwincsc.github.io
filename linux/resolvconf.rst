resolvconf
==========

在 ubuntu 中通过 resolvconf 配置 DNS;

``sudo apt-get install resolvconf``

向 /etc/resolvconf/resolv.conf.d/base 配置文件中添加 DNS 配置项

.. code-block:: shell

   bob@ubuntu:/etc/resolvconf/resolv.conf.d$ cat base
   nameserver 10.220.0.11
   nameserver 10.220.0.12

使用下列配置命令使配置生效
``sudo resolvconf -u``
