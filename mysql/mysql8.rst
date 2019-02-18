mysql8 yum安装后的注意事项
======================================================================

默认登录密码

.. code-block:: shell

   grep 'temporary password' /var/log/mysqld.log

登录后需要修改默认密码, 不然什么也做不了

.. code-block:: shell

   ALTER USER 'root'@'localhost' identified by '同时存在大小写字母, 数字和符号';
