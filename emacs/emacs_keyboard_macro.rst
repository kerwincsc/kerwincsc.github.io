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

  
键盘宏循环
==========


