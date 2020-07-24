============
 文本寄存器
============

- 创建

  :kbd:`C-x r s R` (copy-to-register)
       将选区复制到寄存器 R 中

  若创建时, 没有选中一段选区, Emacs 会将 **mark** 与 **point** 之间的内容复制进去;

  :kbd:`C-u C-x r s R`
       将选区的内容移动到寄存器 R 中

       类似于剪切;

- 追加
  
  :kbd:`M-x append-to-register <RET> R` 将选区追加到寄存器 R 中的文本

  当寄存器 R 中包含的是文本, 可以使用快捷键 :kbd:`C-x r +` (increment-register)
  进行追加; 但是当寄存器的内容是数字时, 不能进行追加 ( 可能会产生算术加的效果 )

  :kbd:`C-u M-x append-to-register <RET> R` 也会产生剪切效果,
       即剪切后追加到寄存器;

  :kbd:`M-x prepend-to-register <RET> R` 不算是追加; 将选区内容插入到寄存器的开头
       ( 原有内容追加在其后 )

  使用两个追加命令时, 可以使用指定的分隔符分隔原有文本和追加的文本;
  以下配置即可配置寄存器的 **追加分隔符**

  .. code-block:: elisp

     ;; 将追加分隔符设置为两个换行符
     (setq register-separator ?+)
     (set-register register-separator "\n\n")

- 使用

  :kbd:`C-x r i R` (insert-register)
       从寄存器 R 中插入文本 ( 到本缓冲区 )

  :kbd:`C-u C-x r i R` 同上, 但是光标 / point 会出现在插入文本的最前方;
       
fg

ab

cd
fg

ab

cd

fg

ab

cd
