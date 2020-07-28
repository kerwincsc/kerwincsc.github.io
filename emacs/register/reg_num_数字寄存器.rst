============
 数字寄存器
============

有一些用于在寄存器中储存数字, 以十进制的方式在 buffer 中插入数字并自增的命令;
这些命令在键盘宏中使用更有效;

- 储存

  :kbd:`C-u NUMBER C-x r n R` (number-to-register)

       将 NUMBER 储存到寄存器 R 中;
       :ref:`不带C-u的命令<no_arg_command>`

- 修改

  :kbd:`C-u NUMBER C-x r + R` (increment-register)

       如果 R 中包含一个数字, 就给寄存器 **加** NUMBER;
     
       如果包含的是文本, 则会做字符串连接; 参考 :doc:`reg_text_文本寄存器`

- 插入

  :kbd:`C-x r i R`

       将 R 中的数字插入到 buffer 中;


  插入命令是寄存器通用的.

.. _no_arg_command:
  
- 其他

  没有参数的 ``C-x r +`` 给寄存器的值加 1;

  没有参数的 ``C-x r n`` 将 0 储存在寄存器中;
