===========
 域 domain
===========

.. rst:directive:: option

   描述命令行参数或开关. 选项参数名称应括在尖括号中. 例子

   .. code-block::

      .. option:: dest_dir

         目标文件夹

      .. option:: -m <module>, --module <module>

         将模块作为脚本运行

   该指令将为给定的选项创建交叉引用目标, 可通过以下方式引用 option
   ( 在示例中, 您将使用类似 *:option:`dest_dir`*, *:option:`-m`*,
   要么 *:option:`--module`*)
