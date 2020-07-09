================
 elisp 符号区别
================

变量操作
========

- 对变量赋值 **setq** 与 定义变量 **defvar**

  `defvar` 是一个特殊表达式;

  与 setq 的不同之处是, 如果 defvar 声明的变量之前已经存在的话,
  defvar 不会改变其值; 但是 defvar 可以修改这个变量的文档;

- 局部作用域变量的设定 let 与 let*
  
  ``let*`` 在变量的声明中就可以使用前面声明的变量, 而 let 不行;


数字和字符串是一类特殊的 **S-表达式**, 它们求值前后不变, 称为自求值表达式 (self-evaluating form);


-------

- set

  一次只能将一个 SYMPOL 设置为变量;

  需要引用;

- setq

  可同时将多个 SYMPOL 设置为变量;
  不需要引用;

- setq-default

  设置默认值

- setq-local

  设置 buffer 本地变量;

defvar

- defconst

  定义在 C 代码中的特殊形式 (special form);

  定义常量

  注: 即使是 defconst 定义的常量变量, 也是可以被改变的;

- defcustom

  自定义变量

动态绑定与词法绑定

- 如何启用词法绑定


  #. 将如下的注释行作为 Emacs Lisp 文件的第一行
    
     .. code-block:: elisp
    
        ;;; -*- lexical-binding: t; -*-

  #. 调用 add-file-local-variable-prop-line

     .. code-block:: elisp

        (add-file-local-variable-prop-line 'lexical-binding t)

