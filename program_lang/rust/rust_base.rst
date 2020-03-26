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

结构体
------

整个实例必须是可变的; Rust 并不允许只将某个字段标记为可变;

可以在函数体的最后一个表达式中构造一个结构体的新实例, 来隐式地返回这个实例;

字段初始化简写语法: 如果结构体中, 参数的名字和结构体的名称相同即可简写为

::

   fn build_user(email: String, username: String) -> User {
       User {
           email, // 原内容为: email: email,
	   username,
	   active: true,
	   sign_in_count: 1,
       }
   }

结构体更新语法: 使用旧实例的大部分值但改变其部分值来创建一个新的结构体实例

::

   let user2 = User {
       email: String::from("another@example.com"),
       username: String::from("anotherusername567"),
       ..user1 // 用旧实例 user1 的其余部分补全 user2 剩下的字段
   };

元组结构体
----------

有着结构体名称提供的含义, 但 **没有具体的字段名, 只有字段的类型**;

定义的每一个结构体有其自己的类型, 即使结构体中的字段有着相同的类型;

元组结构体实例类似于元组: 可以将其 *解构为单独的部分*,
也可以使用 **.** 后跟索引来访问单独的值;

使用
****

- 定义 ``struct Color(i32, i32, i32);``

- 初始化 ``let black = Color(0, 0, 0);``

- 使用 ``black.0``

类单元结构体
------------

一个没有任何字段的结构体;

类似于 **()**, 即 unit 类型;

用在你想要在某个类型上实现 trait 但不需要在类型中存储数据的时候;

备忘
====

Rust中的基本数字类型都默认实现了 Copy Trait, 没有实现Copy Trait的变量，所有权就会被转移.
