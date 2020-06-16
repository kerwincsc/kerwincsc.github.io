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

* ``cargo publish``

* 发布新版本

  发布新版本时, 改变 Cargo.toml 中 version 所指定的值;

* 如果向 crates.io 发布工作空间中的 crate,
  每一个工作空间中的 crate 需要单独发布;

  cargo publish 命令并没有 --all 或者 -p 参数,
  所以必须进入每一个 crate 的目录并运行 cargo publish
  来发布工作空间中的每一个 crate;

撤回
++++

不能删除之前版本的 crate;

可以阻止任何将来的项目将他们加入到依赖中;

撤回某个版本会阻止新项目开始依赖此版本,
不过所有现存此依赖的项目仍然能够下载和依赖这个版本;

为了撤回一个 crate, 运行 cargo yank 并指定希望撤回的版本:

.. code-block:: shell

   $ cargo yank --vers 1.0.1

可以撤销撤回操作, 并允许项目可以再次开始依赖某个版本,
通过在命令上增加 **--undo**

.. code-block:: shell

   $ cargo yank --vers 1.0.1 --undo

撤回 **并没有** 删除任何代码;

工作空间
--------

工作空间只在根目录有一个 Cargo.lock, 而不是在每一个 crate 目录都有 Cargo.lock;

- 依赖内部 crate

  cargo 不假定工作空间中的Crates会相互依赖,
  所以需要明确表明工作空间中 crate 的依赖关系

  .. code-block:: shell

     [dependencies]
		  
     add-one = { path = "../add-one" }

- 依赖外部 crate

  即使 **外部 crate** 被用于工作空间的某处, 也不能在其他 crate 中使用它,
  除非也在他们的 Cargo.toml 中加入 **外部 crate**;

- 为工作空间增加测试

  
为了在非顶层目录运行二进制 crate,
需要通过 **-p** 参数和包名称来运行 ``cargo run`` 指定工作空间中我们希望使用的包

.. code-block:: shell

   cargo run -p <二进制 crate 目录名>

智能指针
========

- **指针** 是 **一个包含内存地址的变量** 的通用 `概念`;

  最常见的指针是 **引用**;

  引用是一类只借用数据的指针; # 区别

- **智能指针** 是一类 **数据结构**, 表现类似指针, 但是拥有额外的元数据和功能;

  `在大部分情况下`, 智能指针 **拥有** 他们指向的数据; # 区别

- 智能指针 **通常使用结构体实现**

  与常规结构体的区别: 其实现了 **Deref** [#Deref]_ 和 **Drop** [#Drop]_ trait

Box 智能指针简述
----------------

-  box 允许你将一个值放在堆上而不是栈上;

   留在栈上的则是指向堆数据的指针

应用场景
++++++++

- 当有一个在 **编译时未知大小的类型**,
  而又 **想要在需要确切大小的上下文中使用** 这个类型值的时候;

  无法在编译时知道大小的类型:-> 递归类型

- 当有 **大量数据** 并希望在 **确保数据不被拷贝** 的情况下 **转移所有权** 的时候

- 当希望拥有一个值并 **只关心它的类型是否实现了特定 trait**
  而不是其具体类型的时候

实现 Deref 的智能指针
---------------------

实现 Deref trait 的智能指针可以被当作常规引用来对待,
可以编写操作引用的代码并用于智能指针;


智能指针类型
------------

- 引用计数 (reference counting) 智能指针 -> 允许数据有多个所有者

Rc<T> 引用计数
--------------

为了启用 **多所有权**;

只能用于 **单线程** 场景;

Rc::clone 只会增加引用计数, 当查找代码中的性能问题时,
只需考虑深拷贝类的克隆而无需考虑 ``Rc::clone`` 调用

RefCell<T> 和内部可变性
------------------------

**内部可变性** (Interior mutability) 是 Rust 中的一个设计模式,
它允许你即使在有不可变引用时改变数据;

借用规则的不可变性:

    - 编译时 -> 引用和 Box<T>

    - 运行时 -> RefCell<T>

只能用于单线程场景;

内部可变性: 不可变值的可变借用
+++++++++++++++++++++++++++++++

借用规则的一个推论是当有一个不可变值时, 不能可变地借用它;


.. rubric:: 备注
	    
.. [#inner_doc] inner doc comments like this (starting with **//!** or **/\*!**)
		can only appear before items
.. [#SPDX] Software Package Data Exchange
.. [#Deref] Deref trait 允许智能指针结构体实例表现的像引用一样,
	    这样就可以编写既用于引用, 又用于智能指针的代码;
.. [#Drop] Drop trait 允许自定义当 **智能指针离开作用域时** 运行的代码;
