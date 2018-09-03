######################################
vboxmanage配置和排障
######################################

配置vbox共享文件夹
===============================

1. 命令行的方式新建共享文件夹:

::

 vboxmanage sharedfolder add <vmname> --name <sharedname>
                         --host-path <sharedpath>
                         [--transient] [--readonly] [--automount]
 如: vboxmanage sharedfolder add work --name share --host-path c:\Users\admin\desktop\share


2. 安装vbox的增强功能 ``Devices->Insert Guest Additions CD Image ... / 设备->安装增强功能..``

   进入Linux的/media, 会看到一个文件, 名字为VBoxAdditions, 进入该目录: ``sudo sh VBoxLinuxAdditions.run``

   过程中若出现 *Building the main Guest Additions module[FAILED]* , 尝试安装 **kernel-devel** 和 **gcc** ,
   其中kernel-devel的版本号要和kernel版本一致, 即要么安装指定版本的kernel-devel, 要么更新内核后安装kernel-devel; 

   安装完成后, 重启系统;

3. 挂载 ``mount -t vboxsf <sharedname> <mountedpath>``, 完成;


解决无法在vbox中共享文件夹无法创建软链接的问题
===================================================

配置好共享文件夹后, 如果你希望在共享文件夹内创建软链接 ``ln -s /home/share /home/kerwin_linux`` 
会出现 ``ln: failed to create symbolic link `node': Read-only file system``,
即使共享文件夹可写;

修复方法: 在VirtualBox里, 允许符号链接: ::

 VBoxManage setextradata <YOURVMNAME> VBoxInternal2/SharedFoldersEnableSymlinksCreate/<YOURSHAREFOLDERNAME> 1

查看设置: ::

 VBoxManage getextradata YOURVMNAME enumerate

如果设置错误, 如何删除设定的extradata项????

