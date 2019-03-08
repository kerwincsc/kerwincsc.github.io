TMUX 终端复用神器
======================================================================

部署
------------------------------------------------------------

- 安装

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

- 添加插件管理

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

操作
------------------------------------------------------------

面板操作
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   "             将当前面板平分为上下两块
   %             将当前面板平分为左右两块
   x             关闭当前面板
   !             将当前面板置于新窗口；即新建一个窗口，其中仅包含当前面板
   Ctrl+方向键 以1个单元格为单位移动边缘以调整当前面板大小
   Alt+方向键     以5个单元格为单位移动边缘以调整当前面板大小
   
   Space         在预置的面板布局中循环切换；依次包括even-horizontal、even-vertical、main-horizontal、main-vertical、tiled

   q             显示面板编号
   o             在当前窗口中选择下一面板
   方向键         移动光标以选择面板
   {             向前置换当前面板
   }             向后置换当前面板
   Alt+o         逆时针旋转当前窗口的面板
   Ctrl+o         顺时针旋转当前窗口的面板

小技巧
------------------------------------------------------------

- 不重启 tmux 的情况重新读取配置文件 ``prefix :`` + ``source-file ~/.tmux.conf``
