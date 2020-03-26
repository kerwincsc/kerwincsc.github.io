===========
 Rust 基础
===========

变量和常量的声明
================

变量
----

默认不可变;

不可变变量
**********

.. code-block:: rust
		
   let x = 5;

可变变量
********

.. code-block:: rust

   let mut x = 5;

常量
----

常量总是不能变;

.. code-block:: rust

   const MAX_POINTS: u32 = 100_000;

名称是 MAX_POINTS, 值是 100,000;

Rust 常量的命名规范是使用下划线分隔的大写字母单词,
并且可以在数字字面值中插入下划线来提升可读性;

不允许对常量使用 mut;


备忘
====

Rust中的基本数字类型都默认实现了 Copy Trait, 没有实现Copy Trait的变量，所有权就会被转移.
