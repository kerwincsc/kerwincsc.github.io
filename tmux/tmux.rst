TMUX 部署
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

窗格操作(pane)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   "             上下方向创建窗格
   %             左右方向创建窗格
   x             关闭当前窗格
   !             将当前窗格置于新窗口；即新建一个窗口，其中仅包含当前窗格
   Ctrl+方向键   以1个单元格为单位移动边缘以调整当前窗格大小
   Alt+方向键    以5个单元格为单位移动边缘以调整当前窗格大小
   Space         在预置的窗格布局中循环切换；依次包括even-horizontal、even-vertical、main-horizontal、main-vertical、tiled
   q             显示窗格编号
   o             在当前窗口中选择下一窗格
   方向键        移动光标以选择窗格
   {             向前置换当前窗格
   }             向后置换当前窗格
   Alt+o         逆时针旋转当前窗口的窗格
   Ctrl+o        顺时针旋转当前窗口的窗格
   z             放大当前窗格(再按即还原)
   i             显示当前窗格信息

窗口操作(window)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   c             创建一个新窗口
   ,             重命名当前窗口
   w             列出所有窗口, 可进行切换
   n             进入下一个窗口
   p             进入前一个窗口
   l             进入之前操作的窗口, 在相邻的两个 window 间切换
   0-9           选择编号对应的窗口
   .             修改当前窗口索引编号
   '             切换到指定编号 ( 可大于9 ) 的窗口 # 状态条会显示 index
   f             根据显示的内容搜索窗格/多个窗口里关键字
   &             关闭 / 删除当前窗口

会话操作(session)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   $             重命名当前会话(tmux rename-session -t {session-old} {new}])

小技巧
------------------------------------------------------------

- 不重启 tmux 的情况重新读取配置文件 ``prefix :`` + ``source-file ~/.tmux.conf``
