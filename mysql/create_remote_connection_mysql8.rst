mysql8 创建远程连接
======================================================================

mysql8和原来的版本有点不一样, 8 的安全级别更高, 所以在创建远程连接用户的时候,
不能用原来的命令, 同时创建用户和赋权:

.. code-block:: mysql

   mysql>grant all PRIVILEGES on *.* to test@'localhost' identified  by '123456';

- 必须先创建用户 (密码规则: mysql8.0 以上密码策略限制必须要大小写加数字特殊符号)

  .. code-block:: mysql

     mysql>create user 'kerwin'@'%' identified by 'tUXefIjl,8328';

- 再进行赋值

  .. code-block:: mysql

     mysql>grant all privileges on *.* to kerwin@'%' with grant option;

- 最后再刷新一下

  .. code-block:: mysql

     mysql>flush privileges;


如当你进行远程连接出现这样的错误时:
/Unable to load authentication plugin 'caching_sha2_password'./

是因为 mysql8 使用的是 caching_sha2_password 加密规则,
最简单的方法是修改远程连接用户的加密规则:

.. code-block:: mysql

   mysql>ALTER USER 'kerwin'@'%' IDENTIFIED WITH mysql_native_password BY 'tUXefIjl,8328';

