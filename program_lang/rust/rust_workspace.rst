=============
Rust 工作空间
=============

创建工作空间
============

#. 新建空白文件夹 ``mkdir test_workspace``;

#. 在 test_workspace 文件夹中, 新建 **Cargo.toml**, 并输入

   ::

      [workspace]
      members = [
          "rtest",
      ]

   最好在 Cargo.toml 中填入待新建的 Cargo 包名后再做下一步, 以防出现警告;
   
#. 在工作空间文件夹下, ``cargo new rtest``


#. 在工作空间运行 rtest 项目 ``cargo run -p rtest``

   会在工作空间目录下生成文件;

工作空间下的 cargo 包的相互导入
===============================

假设将创建 cargo 包 rhello; 包内有名为 hello 的函数;

#. 先在工作空间目录的 Cargo.toml 中填入将要新建的包名

   ::

      [workspace]
      members = [
          "rtest",
          "rhello",
      ]

#. ``cargo new --lib rhello``

   在 lib.rs 中完成 hello 函数的功能

#. 进入 rtest 包中, 编辑 rtest 包内的 Cargo.toml;

   ::

      [dependencies]
      rhello = { path = "../rhello"}

#. 编辑 rtest/src/main.rs, 将 rhello 包引入即可;
