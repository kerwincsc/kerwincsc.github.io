===================
 find 命令常见用法
===================

按权限查找
==========

示例
----

.. code-block:: shell

   # 找出 kubernetes-bins 下所有权限为 755 的文件并做软链接
   find kubernetes-bins -type f  -perm 755 -exec ln -s /root/{} /usr/local/bin/ \;


说明
----

- **-perm** (permission)

  - -perm mode  ->  精确匹配权限

  - -perm -mode  ->  完全包含此 mode 时才可以匹配

  - -perm /mode  ->  任何一位匹配即可

