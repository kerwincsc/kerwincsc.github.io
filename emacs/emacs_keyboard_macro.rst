========
 键盘宏
========


 基本用法
==========

- 定义

  - 开始定义

    - :kbd:`<F3>`

    - :kbd:`C-x (`

    - :command:`kmacro-start-macro-or-insert-counter`

  - 结束定义

    - :command:`kmacro-end-or-call-macro`

      结束和执行都是这个命令
    
    - :kbd:`<F4>`
      
    - :kbd:`C-x )`

  - 给宏命名

    - :command:`kmacro-name-last-macro`

    - :kbd:`C-x C-k n`

- 执行

  - :kbd:`<F4>` (kmacro-end-or-call-macro)

  - :kbd:`C-x e`

    按 e 可多次执行

  - :kbd:`C-x C-k r`

    (apply-macro-to-region-lines)

    在当前光标所在行及由 **set-mark-command** 标记所在行的行首执行键盘宏

  - :kbd:`C-u n <F4>` 执行 n 次键盘宏

- 修改宏定义

  修改宏定义, 先执行最近的一次键盘宏;

    - :kbd:`C-u <F3>`

    - :kbd:`C-u C-x (`

  修改宏定义, 不会执行键盘宏

    - :kbd:`C-u C-u <F3>`

    - :kbd:`C-u C-u C-x (`

  打开键盘宏编辑器界面, 修改键盘宏;

    - :kbd:`C-x C-k <RET>` 完成后键入 :kbd:`C-c C-c` 退出;

      键盘宏编辑器里的内容不是所见即所得, 最好配合 **C-u <F3>** 使用;

- 注意

  输入 :kbd:`C-g` (keyboard-quit) 将退出录制;

  输入 :kbd:`C-M-c` (exit-recursive-edit) 可能会出现问题;

  鼠标参与录制宏时可能出现问题

  
键盘宏环 (Ring)
===============

:kbd:`C-x C-k C-k` (kmacro-end-or-call-macro-repeat)

     执行位于环首的键盘宏

     执行此命令后, 可通过输入 `C-k` 多次重复此宏;
     或通过以下命令切换要执行的宏;

:kbd:`C-x C-k C-n` (kmacro-cycle-ring-next)

     将宏环旋转至下一个宏 ( 先前定义的 )

:kbd:`C-x C-k C-p` (kmacro-cycle-ring-previous)

     将宏环旋转至上一个宏 ( 后来定义的 )

进入宏环操作的状态均以 :kbd:`C-x C-k` 为前缀, 后可接
`C-k` 执行宏, `c-n` 下一个宏, `C-p` 上一个宏,
当前位于环首的宏将显示在回显区;
无须多次重复 `C-x C-k`;

键盘宏计数器
============

每个键盘宏都有与之相关联的计数器, 以 0 开始;
正常情况下, 每调用一次宏, 当前的计数器就递增 1;

主要用于键盘宏中批量生成指定格式的序号;

:kbd:`F3` (kmacro-start-macro-or-insert-counter)

     在宏定义时, 插入计数器值到当前 buffer

:kbd:`C-x C-k C-c` (kmacro-set-counter)

     设置计数器的值, 可以指定从某个值开始;

:kbd:`C-x C-k C-i` (kmacro-insert-counter)

     在当前 buffer 中插入计数器值

:kbd:`C-x C-k C-a` (kmacro-add-counter)

     将计数器的值加上指定值;

:kbd:`C-x C-k C-f` (kmacro-set-format)

     指定要插入的计数器的格式;
     

执行带变体的键盘宏
==================

在宏定义时键入 :kbd:`C-x q`, 当尝试执行宏时, 会询问是否执行宏;

:kbd:`C-x q` (kbd-macro-query)

     定义时输入, 不会有任何效果, 但是在执行时回显区会弹出是否执行的提示;

     以下是回应提示的键:

     - `<SPC>` / `y` 继续执行

     - `<DEL>` / `n` 跳过执行宏的余下部分, 并立即开始下一次重复
       ( 多次执行宏时此项有效, 单次执行与下面的效果相同,
       相当于循环中的 continue )

     - `<RET>` / `q` 跳出宏的执行 ( 相当于循环中的 break )

     - `C-r` 进入递归编辑; 在执行宏前, 对当前位置的内容进行修改;
       修改完成后, 按 `C-M-c` 退出递归编辑, 回显区将会提醒你需要进行的操作;
       按 **<SPC>** 将继续执行宏余下的部分;

:kbd:`C-u C-x q` 暂时搞不明白如何使用;

     定义时键入会取消宏录制;
     执行时键入没反应;

   
键盘宏的命名与保存
==================

- 命名规则

  不能与已有的名称重复: 如果重复则会提示出错, 且不会发生任何改变;

- 命名方法

  :kbd:`C-x C-k n` (kmacro-name-last-macro) 给最近一次使用的宏命名;

- 快捷键绑定

  :kbd:`C-x C-k b` (kmacro-bind-to-key) 将宏绑定到指定的快捷键;

  若选择的快捷键已有绑定, 会提示当前键的绑定函数, 并提示是否确认更改;

  为了防止上述情况的出现, emacs 保留 :kbd:`C-x C-k 0` 到 :kbd:`C-x C-k 9` 和
  :kbd:`C-x C-k A` 到 :kbd:`C-x C-k Z` 用作自定义宏的快捷键; 注意: 是大写的 A-Z;


- 使用

  - 已命名的宏, 可以通过 **M-x** 使用;

  - 绑定快捷键的宏, 直接通过快捷键使用;

  - 载入保存宏的文件

    #. ``M-x load-file <RET> FILENAME``

    #. 写进 **.emacs.d/init.el** 或 **.emacs** 配置文件中;

- 保存

  保存宏以在其他会话中使用此宏;

  #. 给要保存的宏命名;

  #. 新建一个保存宏定义的文件

  #. ``M-x insert-kbd-macro <RET> MACRONAME <RET>``

宏相关变量
==========

**kmacro-ring-max** 存储于宏环中的最大宏数量;
