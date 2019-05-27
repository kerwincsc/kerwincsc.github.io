Linux 系统管理速查
======================================================================

- 查看cpu占用前10的进程

  .. code-block:: shell

     # ps auxw|head -1 是为了打印表头
     ps auxw|head -1;ps auxw --no-header|sort -rn -k3|head -10

