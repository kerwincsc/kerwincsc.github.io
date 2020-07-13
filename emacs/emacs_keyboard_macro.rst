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

宏相关变量
==========

**kmacro-ring-max** 存储于宏环中的最大宏数量;
