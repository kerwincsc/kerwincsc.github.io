kvm部署
======================================================================

命令行安装 centos7

::

   virt-install \
   --name=host-name \
   --memory=512,maxmemory=1024 \
   --vcpus=1,maxvcpus=2 \
   --os-type=linux --os-variant=rhel7 \
   --location=/tmp/CentOS-7-x86_64-DVD-1503-01.iso \
   --diskpath=/kvm_data/host-name.img,size=10 \
   --bridge=br0 \
   --graphics=none \
   --console=pty,target_type=serial \
   --extra-args="console=tty0 console=ttyS0"

安装完成后, 会重启机器, 连宿主机也会一并重启;
请注意, 安装完成后, :kbd:`Ctrl+]` 到宿主机, 重启刚刚安装的虚拟机;



虚拟机管理
------------------------------------------------------------

- 克隆虚拟机

  ::

     virt-clone \
     --original src-virt-name --name new-virt-name \
     --file /kvm_data/new-virt-name.img

  --original 指定克隆源虚拟机

  --name 指定克隆后的虚拟机名字

  --file 指定目标虚拟机的虚拟磁盘文件

  如果待克隆虚拟机是开机状态, 则提示先关闭或者暂停虚拟机;

- 快照管理

  - 创建快照 ``virsh snapshot-create virt-name``

    **raw** 格式的虚拟磁盘不支持做快照, ``qcow2`` 支持

  - 查看快照 ``qemu-img info /kvm_data/virt-name.img``

    同时会看到快照列表, 

  - 列出所有快照 ``virsh snapshot-list virt-name``
  - 查看当前快照版本 ``virsh snapshot-current virt-name``
  - 查看所有快照配置文件 ``ls /var/lib/libvirt/qemu/snapshot/virt-name``
  - 恢复指定快照 ``virsh snapshot-revert virt-name snapshot-id``
  - 删除快照 ``virsh snapshot-delete virt-name snapshot-id``

- 磁盘管理

  虚拟磁盘常用格式raw, qcow2

  - 查看虚拟磁盘格式 ``qemu-img info /kvm_data/virt-name.img``
  - 创建 2G 的 raw 的磁盘格式
    ``qemu-img create -f raw /kvm_data/virt-name_2.img 2G``
  - 将 raw 格式的磁盘转换为 qcow2 格式
    ``qemu-img convert -O qcow2 /kvm_data/virt-name_2.img /kvm_data/virt-name_2.qcow2``

    转换后用 **ls -lh** 查看磁盘文件的大小, 可以看到 qcow2 文件比较小,
    raw 文件大小与我们自己指定空间大小一样是 2G;

    raw 格式的磁盘性能比 qcow2 要好, 但是 raw 格式的磁盘无法做快照

  - 更改文件和路径 ``virsh edit virt-name``

常用命令
------------------------------------------------------------

- 安装完虚拟机需要重启, 要退出虚拟机使用快捷键 :kbd:`Ctrl + ]`
- 查看虚拟机列表, 只能看到未运行的虚拟机 ``virsh list``,
  查看所有 ``virsh list --all``
- 启动虚拟机 ``virsh start virt-name``
- 进入终端 ``virsh console virt-name``
- 关闭虚拟机 ``virsh shutdown virt-name``
- 强制停止 ``virsh destroy virt-name`` 类似于 stop
- 挂起 ``virsh suspend virt-name``
- 恢复 ``virsh resume virt-name``
- 彻底销毁虚拟机 ``virsh undefine virt-name`` 会删除虚拟机配置文件,
  virsh list --all 就看不到了, 仅删除了配置文件, 镜像文件还在;
- 查看虚拟机配置文件 ``ls /etc/libvirt/qemu/``
- 随宿主机开机而启动 ``virsh autostart virt-name``,
  取消 ``virsh autostart --disable virt-name``
