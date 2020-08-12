============
 文件寄存器
============

如果频繁地访问某些文件, 把这些文件名放在寄存器里之后再行访问, 就会更加便捷;

将文件名 NAME 放进寄存器 R 中 ``(set-register R '(file . NAME))``

例如: (set-register ?z '(file . "/gd/gnu/emacs/19.0/src/ChangeLog"))
就是将指定文件名放在寄存器 z 中;

(set-register ?g '(file . "/Users/kerwin/github/sphinx/source/emacs/register/reg_file_文件寄存器.rst"))

和访问其它寄存器相同, 访问寄存器 R 中的文件名, 键入 :kbd:`C-x r j R`




