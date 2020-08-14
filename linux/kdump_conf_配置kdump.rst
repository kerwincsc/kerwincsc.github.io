============
 配置 kdump
============

:term:`简介<kdump>`

#. 安装 kexec-tools

   使用 kdump 服务, 必须要用到 kexec-tools 工具包
   ``yum install kexec-tools``

#. 配置 kdump kernel

   需要为 kdump kernel 配置内存区域, kdump 要求系统正常使用时,
   不能使用 kdump kernel 所占用的内存;

   #. 修改grub文件 ``vim /etc/default/grub``

      将 **GRUB_CMDLINE_LINUX="crashkernel=auto..."**
      中的 auto 修改为 128M. 一般设为 128M 或 256M;

   #. 更新grub配置

      只要更改了 grub 文件, 都需要更改 grub 配置
      ``sudo grub2-mkconfig -o /boot/grub2/grub.cfg``

   #. 重启系统

#. 修改 kdump 默认配置 ``vim /etc/kdump.conf``

   .. code-block:: bash

      path /var/crash            #指定coredump文件放在/var/crash文件夹中
      #加上-c表示压缩，原文件中没有
      core_collector makedumpfile -c -l -message-level 1 -d 31
      default reboot         #生成coredump后，重启系统
      
#. 开启 kdump 服务

   .. code-block:: bash

      systemctl start kdump.service     //启动kdump
      systemctl enable kdump.service    //设置开机启动

#. 测试 kdump 是否开启

#. 手动触发 crash

   .. code-block:: bash

      #echo 1 > /proc/sys/kernel/sysrq
      #echo c > /proc/sysrq-trigger

   如果配置成功, 系统将自动重启, 重新进入系统,
   可以看到 /var/crash 文件夹下生成了相应文件,
   是一个以生成 coredump 日期为文件名的文件

   在实际维护中, 服务器按如上操作配置了 kdump 有时仍无法生成 vmcore 文件,
   如系统 hung 死. 对于这些特殊的情况, 红帽提供了两种手动触发 kdump 的方法:

     - 魔术键

       #. 修改 /etc/sysctl.conf 文件中的 **kernel.sysrq = 1**

       #. sysctl -p 生效

       #. 在配置成功魔术键之后可以通过按下如下组合键, 触发系统Crash
          **alt+printscreen+c**

          如果系统 hung 机后, 键盘已无响应, 则这种方法无法触发系统 Crash,
          此时需要使用 nmi button, 它会产生一个不可屏蔽中断, 使内核crash
          
     - NMI button

       #. 修改 /etc/sysctl.conf 文件
          **kernel.unknown_nmi_panic = 1**

       #. sysctl -p 生效
          
       #. 配置成功 NMI button 之后, 发生死机时,
          可以通过按主机的 NMI BUTTON 触发 CRASH.

   如果 kdump 可以正常工作, 就可以抓取到系统 hung 住时刻的 vmcore 文件;
   以上两中方法可以同时配置;
