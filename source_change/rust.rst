=============
 RUST 更换源
=============

RUSTUP配置和使用
================

国内更新镜像

设置环境变量 **RUSTUP_DIST_SERVER** ( 用于更新 toolchain )

**RUSTUP_UPDATE_ROOT** ( 用于更新 rustup )

::

   export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"
   export RUSTUP_UPDATE_ROOT="https://mirrors.ustc.edu.cn/rust-static/rustup"

官方的默认地址是 ::

  export RUSTUP_UPDATE_ROOT="https://static.rust-lang.org/rustup/dist"

在配置完成后再安装 *rustup*

Crates 配置国内镜像
===================

在 **$HOME/.cargo/config** 中添加如下内容 ::

  [registry]
  index = "git://mirrors.ustc.edu.cn/crates.io-index"

如果所处的环境中不允许使用 git 协议, 可以把上述地址改为 ::

  index = "http://mirrors.ustc.edu.cn/crates.io-index"

如果 cargo 版本为 0.13.0 或以上, 需要更改 **$HOME/.cargo/config** 为以下内容

::

   [source.crates-io]
   registry = "https://github.com/rust-lang/crates.io-index"
   replace-with = 'ustc'
   [source.ustc]
   registry = "git://mirrors.ustc.edu.cn/crates.io-index"
