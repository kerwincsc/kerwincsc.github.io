====================
 GLIBC_出错补救方式
====================

尝试安装 Starship 时发现需要提高 openssl 库的版本;
搞定 openssl 后发现需要 glibc-2.18 以上的库文件;
编译完成 glibc 并把新的库文件的路径加入 ldconfig 后,
发现仍然提示需要 glibc-2.18 以上的库文件;
尝试将 **libc.so.6 -> libc-2.17.so** 更改为 **libc.so.6 -> libc-2.18.so**,
执行 ls 命令时出错

.. code-block:: shell

   # 1. 将编译好的新的指向 2.18 的 libc.so.6 软链接直接拷贝为
   # /lib64/libc.so.6.bak_2.18
   # 2. 将原有的指向 libc-2.17.so 的 libc.so.6 移动为 libc.so.6.bak_2.17
   # 3. 将 /lib64/libc.so.6.bak_2.18 移动为 /lib64/libc.so.6
   # 执行 ls 出现以下效果
   ls: error while loading shared libraries: libc.so.6:
   cannot open shared object file: No such file or directory

   # 利用 LD_PRELOAD 删除/lib64/libc.so.6 后执行 ldconfig 就出现如下情况了
   ls: relocation error: /lib64/libpthread.so.0: symbol __h_errno,
   version GLIBC_PRIVATE not defined in file libc.so.6 with link time reference

- 临时恢复基础命令的使用

  ``LD_PRELOAD=/lib64/libc-2.17.so ls | mv | rm ..``
                
- 修复方式

  利用 :doc:`LD_PRELOAD 变量<LD_PRELOAD_环境变量>` 

  #. 进入/lib64目录，使用 ls -ltr 命令

     找到所有指向错误的库文件, 比如指向了 libc-2.18.so

  #. 删除此软链接

     ``LD_PRELOAD=/lib64/libc-2.17.so rm libc.so.6``

  #. 重建正确指向的软链接即可

     ``LD_PRELOAD=/lib64/libc-2.17.so ln -sf libc-2.17.so libc.so.6``

     -f 强行写入
