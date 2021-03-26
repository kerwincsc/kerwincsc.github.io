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
