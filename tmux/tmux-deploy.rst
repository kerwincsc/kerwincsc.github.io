TMUX 部署
======================================================================

安装
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

.. code-block:: shell

   $ git clone https://github.com/tmux/tmux.git
   $ cd tmux
   $ sh autogen.sh
   $ ./configure && make

如果提示缺少 libevent, 安装 ``yum install libevent-devel`` 后, 重新配置即可;

.. code-block:: shell
		
   # 编译出来的程序在 tmux 目录内，这里假设你还没离开 tmux 目录
   cp tmux /usr/bin/tmux -f
   cp tmux /usr/local/bin/tmux -f

添加插件管理
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

.. code-block:: shell

   # 将 Tmux Plugin Manager 库复制到本地
   $ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

   # 把以下内容放入 ~/.tmux.conf 尾部
   # List of plugins
   set -g @plugin 'tmux-plugins/tpm'
   set -g @plugin 'tmux-plugins/tmux-sensible'

   # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
   run -b '~/.tmux/plugins/tpm/tpm'

   # Reload TMUX environment so TPM is sourced:
   # type this in terminal if tmux is already running
   $ tmux source ~/.tmux.conf
     
- 安装会话恢复插件 tmux-resurrect

  .. code-block:: shell

     # 在 ~/.tmux.conf 中加入此项
     set -g @plugin 'tmux-plugins/tmux-resurrect'

- 安装 ``prefix + shift-i``

- 升级 ``prefix + shift-u``

- 反安装 ``prefix + alt-u``

  将没有出现在 *tmux.conf* 中的插件全部移除
