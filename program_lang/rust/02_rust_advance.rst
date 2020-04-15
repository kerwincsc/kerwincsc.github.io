===========
 Rust 进阶
===========

闭包
====

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

以 ``//!`` 或 ``/\*!`` 开头的 `内部文档注释` 仅能出现在项的前面 [#inner_doc]_;

使用 pub use 导出合适的公有 API
--------------------------------

导出了公有的 API, 方便在手册中进行查找, 主要方便了使用 crate 的开发者;

pub use 提供了解耦组织 crate 内部结构和与终端用户体现的灵活性

Crates.io 账号
-------------------

#. 在 crates.io 上注册账号并获取一个 API token

   查看位于 https://crates.io/me/ 的账户设置页面并获取 API token

#. 使用 API token 运行 ``cargo login`` 命令

   ``$ cargo login abcdefghijklmnopqrstuvwxyz012345``

   命令会通知 Cargo 你的 API token 并将其储存在本地的 ~/.cargo/credentials 文件中

crate 操作
----------

发布
++++

* 需要在 crate 的 Cargo.toml 文件的 [package] 部分
  增加一些本 crate 的元信息 (metadata)

* crate 需要一个唯一的名称;

  修改 Cargo.toml 中 [package] 里的名称为你希望用于发布的名称

* crate 用途的描述和用户可能在何种条款下使用该 crate 的 license

  增加 description 和 license;

  如果你希望使用不存在于 SPDX [#SPDX]_ 的 license,
  则需要将 license 文本放入一个文件, 将该文件包含进项目中,
  接着使用 **license-file** 来指定文件名而不是使用 license 字段;


.. rubric:: 备注
	    
.. [#inner_doc] inner doc comments like this (starting with **//!** or **/\*!**)
		can only appear before items
.. [#SPDX] Software Package Data Exchange
