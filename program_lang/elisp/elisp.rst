elisp 符号区别
======================================================================

变量操作
------------------------------------------------------------

- 对变量赋值 **setq** 与 定义变量 **defvar**

  `defvar` 是一个特殊表达式;

  与 setq 的不同之处是, 如果 defvar 声明的变量之前已经存在的话,
  defvar 不会改变其值; 但是 defvar 可以修改这个变量的文档;

- 局部作用域变量的设定 let 与 let*
  
  ``let*`` 在变量的声明中就可以使用前面声明的变量, 而 let 不行;


数字和字符串是一类特殊的 **S-表达式**, 它们求值前后不变, 称为自求值表达式 (self-evaluating form);