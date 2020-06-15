Rust 工作空间
=============

#. 新建空白文件夹 ``mkdir <workspace_name>``;

#. 在 <workspace_name> 文件夹中, 新建 **Cargo.toml**, 并输入

   ::

      [workspace]
      members = [
          "<此文件夹下其它文件夹的名称>",
          [...,]
      ]
#. 在工作空间文件夹下, ``cargo new rtest``

   将 项目名 rtest 填入 workspace 下的 members 列表中:

   ::

      [workspace]
      members = [
          "rtest"
      ]

#. 在工作空间运行 rtest 项目 ``cargo run -p rtest``

   会在工作空间目录下生成文件;
