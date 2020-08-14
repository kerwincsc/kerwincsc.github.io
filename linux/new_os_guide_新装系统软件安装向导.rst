======================
 新装系统软件安装向导
======================

#. git

   ``dnf install git -y``
#. zsh

   #. ``dnf install zsh -y``

   #. 切换默认 shell

      - 使用 :abbr:`chsh(change shell)` 工具: ``dnf install util-linux-user -y``

        ``chsh -s /usr/bin/zsh <user-name>``
      
      - 使用 usermod 修改指定用户的 shell

        实际更改了 /etc/passwd/ 里的 shell 字段

        ``usermod -s /usr/bin/zsh <user-name>``
   #. 安装 oh-my-zsh

      - ``$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"``

#. rustup

   - 安装 rust 语言环境

     ``curl https://sh.rustup.rs -sSf | sh -s``

   - :ref:`更新镜像源<rust_mirrors_ustc>`

   - 更新路径

     export PATH=/root/.cargo/bin/:$PATH

#. 安装编译工具及依赖

   - dnf install gcc -y

   - dnf install openssl-devel -y

#. 安装 rust 版的 :abbr:`tldr(too long, don't read)`: tealdeer

   cargo install tealdeer
