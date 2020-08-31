==================
 类似寄存器的书签
==================

"书签" 在某种程度上和寄存器很像, 都可以记录位置, 稍后再跳转过去.
与寄存器不同, 书签名比较长, 并且从一个 Emacs 会话到另一个会话, 它们自动留存;
书签的经典用法是记录你正在读的文件的位置

:kbd:`C-x r m <RET>` 在当前位置给文件设定书签

     默认使用文件名作为书签名

:kbd:`C-x r m BOOKMARK <RET>` (bookmark-set)
     在当前位置设置一个叫 BOOKMARK 的书签     
     
:kbd:`C-x r M BOOKMARK <RET>`
     类似于 `C-x r m`, 但是不会覆盖已经存在的书签;
     如果确实选择了一个已存在的书签, 会有提示

:kbd:`C-x r b BOOKMARK <RET>` (bookmark-jump)
     跳到名为 BOOKMARK 的书签

:kbd:`C-x r l` (list-bookmarks)
     列出所有的书签

:kbd:`M-x bookmark-save`
     将所有当前书签值保存进默认的书签文件中, 即 **~/.emacs.d/bookmarks**

如果把 ``bookmark-save-flag`` 设为 1, 即使 Emacs 崩溃, 设定的书签也能保存下来;
如果该值设为 nil, 则需要显式调用书签保存命令才能保存书签

变量 ``bookmark-default-file`` 指定了保存书签的默认文件;

书签位置值与周围的上下文一起保存, 所以 ``bookmark-jump`` 能够找到合适的位置,
即使文件已经做了轻微的修改;

变量 ``bookmark search size`` 表示要在书签位置的每一侧记录多少个上下文字符;

:kbd:`bookmark-load <RET> FILENAME <RET>`
     载入指定的书签文件

:kbd:`bookmark-write <RET> FILENAME <RET>`
     将当前的书签存入到 FILENAME 中, 配合 bookmark-load 使用

:kbd:`bookmark-insert-location <RET> BOOKMARK <RET>`
     向 buffer 中插入书签 BOOKMARK 指向的文件名

:kbd:`bookmark-insert <RET> BOOKMARK <RET>`
     向 buffer 中插入书签 BOOKMARK 指向的内容, 慎用
