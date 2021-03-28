==============
 编译安装选项
==============

- 编译命令

  ``./configure --prefix=/usr/local/emacs --with-mailutils --with-sound=no --without-selinux  --with-libsystemd --with-json``

- configure 结果

  .. code-block:: shell

     # without-selinux
     Does Emacs use -lselinux?                               no
     # dnf/yum install gnutls-devel
     Does Emacs use -lgnutls?                                yes
     # dnf/yum install libxml2-devel     
     Does Emacs use -lxml2?                                  no
     Does Emacs use -lfreetype?                              no
     Does Emacs use HarfBuzz?                                no
     Does Emacs use -lm17n-flt?                              no
     Does Emacs use -lotf?                                   no
     Does Emacs use -lxft?                                   no
     # dnf/yum install systemd-devel
     Does Emacs use -lsystemd?                               yes
     # dnf/yum install jansson-devel
     Does Emacs use -ljansson?                               yes

- 不建议添加的编译选项

  **--enalbe-profiling** 这个选项打开后, 编译生成的 emacs 进程在被关闭后,
  会在当前目录生成 gmon.out 文件, 用于 debug emacs;
