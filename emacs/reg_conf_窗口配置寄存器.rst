================
 窗口配置寄存器
================

可将所选 frame 的窗口配置保存到寄存器中,
甚至可以保存所有 frame 中所有窗口的配置, 并在以后恢复配置;

:kbd:`C-x r w R` (window-configuration-to-register)

     将选定的 frame 的窗口状态保存在寄存器 R 中

:kbd:`C-x r f R` (frameset-to-register)

     在寄存器 R 中保存所 frame 的 ( 包括其所有的窗口 ) 的状态;


使用 :kbd:`C-x r j R` 恢复窗口或 frame 的配置.
这个命令与位置寄存器的恢复命令相同.
恢复 frame 配置时, 配置中未包含的任何现有 frame 都将不可见;
删除这些 frame, 使用 :kbd:`C-u C-x r j R` 即可;

