Kali Linux 持久加密USB安装
=====================================================================

1. 向 USB 中写入 Live CD 镜像
-----------------------------------------------------------

#. UltraISO 软磁通

#. dd 命令

   ``dd if=kali.iso of=/dev/sdb bs=1M``

2. 制作加密部分
------------------------------------------------------------

#. 为U盘创建额外分区

   使用命令行分区工具 `parted`
   select /dev/sdb 选择U盘进行分区
   mkpart primary [start] [end]


#. 使用 LUKS 加密分区

   cryptsetup --verbose --verify-passphrase luksFormat /dev/sdb3

#. 打开加密分区

   cryptsetup luksOpen /dev/sdb3


#. 格式化加密分区及卷标

   mkfs.ext4 /dev/mapper/usb
   e2label /dev/mapper/usb persistence 卷标的名字必须是 `persistence`


#. 挂载加密分区, 并创建 persistence.conf文件 ::

     mkdir -p /mnt/usb
     mount /dev/mapper/usb /mnt/usb
     echo "/ union" > /mnt/usb/persistence.conf


#. 卸载加密分区并关闭加密分区 ::

     umount /dev/mapper/usb
     cryptsetup luksClose /dev/mapper/usb
