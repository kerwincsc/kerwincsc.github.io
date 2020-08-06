=========
 history
=========

显示操作时间
============

- bash

  .. code-block:: shell

     export HISTTIMEFORMAT='%F %T '

- zsh

  .. code-block:: shell

     # 日期显示方式为 MM.DD.YYYY
     $ history -E
     1   2.12.2013 14:19  cd ..

     # 日期显示方式为 YYYY-MM-DD
     $ history -i
     1  2013-12-02 14:19  history -E

     # 显示命令消耗时长
     $ history -D
     1  0:00  history -E
     2  0:00  history -I
     
