创建删除与修改用户
======================================================================

- 创建

  .. code-block:: mysql

     CREATE USER 'jackson'@'localhost' identified by 'jiUYjh&89';

- 修改

  - 修改用户密码

    .. code-block:: mysql

       ALTER USER 'jackson'@'localhost' identified by 'ADjk*123';

  - 修改为可远程连接

    .. code-block:: mysql

       UPDATE USER set host='%' WHERE USER='jackson';

- 删除

  .. code-block:: mysql

     DELETE FROM user WHERE user='jackson' and host='localhost';


如果修改用户后权限未及时更新, 请执行 ``mysql>flush privileges;`` ;
