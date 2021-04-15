================
 linux 密码忘记
================

- pve

  #. 启动到 Grub

  #. 按 e 编辑相应的内核文件

  #. 找到以 **linux /boot/vmlinuz** 开头的行,
     在其结尾添加 ``init=/bin/bash``

  #. 按 **Ctrl+X** 启动, 并进行如下操作

     .. code-block:: shell

	mount -rw -o remount / # 不知道这步的含义, 下次可尝试直接修改密码
	passwd
