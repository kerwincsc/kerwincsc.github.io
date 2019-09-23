==================
 文本三神器之 AWK
==================

- 语法格式

  ``awk 'BEGIN{}pattern{commands}END{}' file_name``

  语法格式说明:

  .. code-block:: shell

     语法格式      解释
     BEGIN{}       正式处理数据之前执行
     pattern       匹配模式
     {commands}    处理命令, 可能多行
     END{}         处理完所有匹配数据后执行

格式化输出之 printf
===================



格式说明符
----------

.. code-block:: shell

   格式符      含义
   %s          打印字符串
   %d          打印十进制数
   %f          打印一个浮点数
   %x          打印十六进制数
   %o          打印八进制数
   %e          打印数字的科学计数法形式
   %c          打印单个字符的 ASCII 码

内置变量对照表
==============

  .. code-block:: shell

     内置变量  含义
     $0        整行内容
     $1-$n     当前行的第 1-n 个字段
     NF        当前行的字段个数, 也就是有多个列 number of field
     NR        当前行的行号, 从 1 开始计数
     FNR       多文件处理时, 每个文件行号单独计数, 都是从 0 开始 File Number Row
     FS        输入字段分隔符. 不指定则默认以空格或 tab 键分割 Field Separator
     RS        输入行分隔符. 默认回车换行. Row S eparator            
     OFS       输出字段分隔符. 默认空格
     ORS       输出行分隔符. 默认为回车换行.
     FILENAME  处理文件的文件名
     ARGC      命令行参数个数
     ARGV      命令行参数数组
     
