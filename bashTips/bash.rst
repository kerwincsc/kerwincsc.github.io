BASH
======================================================================

历史记录
------------------------------------------------------------

``-o history`` 打开;

#. shell 变量
   **HISTSIZE** 历史记录大小, 默认500;
   **HISTIGNORE and HISTCONTROL**
   **HISTFILE** 默认值是 ~/.bash_history, bash 启动时读取此变量指定的文件
   中的记录作为历史记录;
   **HISTFILESIZE** 
   **HISTTIMEFORMAT**

#. shell 选项
   histappend
   cmdhist
   lithist

#. 内置命令

::
  fc [#fc]_ [-e ename] [-lnr] [first] [last]
  fc -s [pat=rep] [command]

fc -l 仅列出最近的 16 条命令;
fc -l 100 仅列出 第100条到最近一条的命令;
fc -l 10 100 列出指定范围的命令;
fc -l -n 列出命令时, 不显示命令的序号;
fc -l -r 反向列出命令;
fc -e emacs 以 emacs 打开并显示最近一条命令;

   

#. 变量 ``FCEDIT`` 指定了显示或修改命令的编辑器

--------

.. [fc] Fix Command
