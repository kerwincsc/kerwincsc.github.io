===========
 Rust 进阶
===========

 闭包
======

当闭包从环境中捕获一个值, 闭包会 **在闭包体中储存** 这个值以供使用;

闭包可以通过三种方式捕获其环境:

  #. 获取所有权 FnOnce

  #. 可变借用 FnMut

  #. 不可变借用 Fn

如果你希望强制闭包获取其使用的环境值的所有权, 可以在参数列表前使用 move 关键字.
这个技巧在 **将闭包传递给新线程以便将数据移动到新线程中** 时最为实用;

迭代器
======

使用 for 循环时无需使 迭代器 可变,
因为 for 循环会获取 迭代器 的所有权并在后台使 迭代器 可变;

Cargo 及 Crate.io
=================

Cargo 有两个主要的配置:

  * 运行 ``cargo build`` 时采用的 **dev** 配置

  * 运行 ``cargo build --release`` 的 **release** 配置

dev 配置被定义为开发时的好的默认配置, release 配置则有着良好的发布构建的默认配置;

当项目的 Cargo.toml 文件中没有任何 [profile.*] 部分的时候,
Cargo 会对每一个配置都采用默认设置;
通过增加任何希望定制的配置对应的 [profile.*] 部分, 我们可以选择覆盖任意默认设置的子集;


Cargo.toml 配置说明
-------------------

opt-level 0-3 设置控制 Rust 会对代码进行何种程度的优化


文档注释
--------

使用三斜杠 ``///`` 以支持 Markdown 注解来格式化文本.
文档注释就位于需要文档的项的之前;

注释包含项的结构
----------------

另一种风格的文档注释 ``//!``, 这为包含注释的项, 而不是注释之后的项增加文档.
这通常用于 crate 根文件 ( 通常是 src/lib.rs )
或模块的根文件为 crate 或模块整体提供文档;

以 ``//!`` 或 ``/\*!`` 开头的 `内部文档注释` 仅能出现在项的前面;


.. inner doc comments like this (starting with `//!` or `/\*!`)
   can only appear before items