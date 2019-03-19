======================================================================
升级CentOS 7内核版本
======================================================================

本次内核升级是为了使用缓存查看工具 cachestat/cachetop,
此二者需要4.1版本以上内核的支持;

- 载入elrepo源, 搜索内核更新资源, 并进行更新操作;

  .. code-block:: shell

     rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

- 安装ELRepo

  .. code-block:: shell

     rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

- 载入elrepo-kernel元数据

  .. code-block:: shell

     # 默认情况下, 此库不启用
     yum --disablerepo=\* --enablerepo=elrepo-kernel repolist


- 查看可用的rpm包

  .. code-block:: shell

     yum --disablerepo=\* --enablerepo=elrepo-kernel list kernel*

- 安装最新版本的kernel

  .. code-block:: shell 

     yum --disablerepo=\* --enablerepo=elrepo-kernel install -y kernel-ml.x86_64

  重启, 选择新版本内核进入系统

- 最后, 需要将内核工具包一并升级

  - 删除旧版本工具包

    .. code-block:: shell

       yum remove kernel-tools-libs.x86_64 kernel-tools.x86_64

  - 安装新版本工具包

    .. code-block:: shell

       yum --disablerepo=\* --enablerepo=elrepo-kernel install -y kernel-ml-tools.x86_64



- 将新安装的内核设定为操作系统的默认内核

  .. code-block:: shell

     grub2-set-default 0
     grub2-mkconfig -o /etc/grub2.cfg # grub2-efi.cfg

- 备注

  kernel-ml: kernel-ml 中的 ml 是英文 *mainline stable* 的缩写,
  elrepo-kernel 中罗列出来的是最新的稳定主线版本;

  kernel-lt: kernel-lt 中的 lt 是英文 *long term support* 的缩写,
  elrepo-kernel中罗列出来的长期支持版本;
