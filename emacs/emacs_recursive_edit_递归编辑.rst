==========
 递归编辑
==========

递归编辑级别以一对包裹主次模式的方括号为指示 [#mac]_;

递归编辑支持嵌套;

在任何情况下, 都可以在递归编辑中以正常方式切换缓冲区;

不建议持续在递归编辑级别下编辑文档, 这可能会发生栈溢出;
不用时, 及时退出;

尽量减少在GNU Emacs中使用递归编辑级别:
因为它们约束你按特定的顺序返回 —— 从最内层到顶层;



- 退出 | Exit
  
  退出递归编辑级别, 键入 :kbd:`M-x top-level`; 退出所有递归编辑;
  
  **退出** 递归编辑意味着返回未执行结束的命令, 退出命令是 :kbd:`C-M-c`
  (exit-recursive-edit); 仅退出最外层的递归编辑级别;

- 放弃 | Abort

  **放弃** 递归编辑. 类似退出, 但是会立刻退出未执行完成的命令,
  使用 :kbd:`C-]` (abort-recursive-edit) 放弃; 仅退出一层递归编辑级别;

.. [#mac] 在 mac 命令行 emacs 下, 未看到效果;
          
