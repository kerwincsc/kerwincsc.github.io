===============
 emacs基本操作
===============

导航
====

- 跳转到指定行

  - 命令 ``goto-line``
  - 快捷键 :kbd:`M-g g` 或 :kbd:`M-g M-g`

- 打开文件到指定行或指定行和列

  - emacs +LINE FILE

    打开 FILE 文件并跳到 LINE 行

  - emacs +LINE:COLUMN FILE

    打开 FILE 文件并跳到 LINE 行 COLUMN 列

文件浏览
========

- 打开 / 取消只读模式

  - 命令 ``read-only-mode``
  - 快捷键 :kbd:`c-x c-q`

- 以只读模式打开文件

  - 命令 ``find-file-read-only``
  - 快捷键 :kbd:`c-x c-r`

文件修改
========

- 删除行尾 **^m** ``m-x replace-string ret c-q c-m ret``

撤消与重做 undo redo
--------------------

- 撤消

  - 命令 ``undo``
  - 绑定的快捷键 :kbd:`c-_`  :kbd:`c-/`  :kbd:`c-x u`

- 重做

  如果用快捷键撤消一些更改之后, 想要恢复被撤消的内容, 则需要 *向前撤消*,
  即 :kbd:`c-f c-_`;

查找及替换
----------

- 查找并替换 :kbd:`m-%`

  输入要被替换的词, 回车, 然后输入要替换的词, 再回车;

  被替换的词会高亮起来, 这时, 输入 **y** 替换并跳到下一个;
  输入 **q** 结束, 输入 **!** 替换剩下全部;

  常用选项:

  - :kbd:`c-g` 中断查找替换过程
  -  **^** 返回上一个替换点, 按 y 继续下一个; 如果不想替换上一个的话, 用 **^**
     返回到上一个, 然后按 :kbd:`C-r` 进入编辑,
     修改完成后按 :kbd:`C-M-c` 退出继续下一个;
  - :kbd:`C-l` 使当前匹配显示在文档中间

    这个其实与查找替换过程无关, 默认就会将当前行置于文档中间;

  - :kbd:`C-r` 进入修改

注释
----

- 多行注释

  多行注释的另类实现 ::

    1. 选中一段区域到最后一行行首
    2. 按 C-x r t -> 实际调用了命令 string-rectangle
    3. 输入注释内容 -> 根据编程语言自行确定

- 反多行注释

  ::

     1. 选中一段区域到最后一行，紧挨着注释字符之后的位置
     2. 按 c-x r k -> 实际调用了命令 kill-rectangle


界面调整
========

调整分屏大小
------------

- xterm-mouse-mode, 然后用鼠标拖
- :kbd:`C-x }`, enlarge-window-horizontally, 使分屏左右变大;

  :kbd:`C-x {`, shrink-window-horizontally, 使分屏左右变小;

  :kbd:`C-x ^`, enlarge-window, 使分屏上下变大;
