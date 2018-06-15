============================================================
vboxmanage命令参考手册
============================================================

snapshot-快照
--------------------------------------------------

用法: ::

  VBoxManage snapshot <uuid|vmname>
                      take <name> [--description <desc>] [--live]
                      [--uniquename Number,Timestamp,Space,Force] |
                      delete <uuid|snapname> |
                      restore <uuid|snapname> |
                      restorecurrent |
                      edit <uuid|snapname>|--current
                      [--name <name>]
                      [--description <desc>] |
                      list [--details|--machinereadable] |
                      showvminfo <uuid|snapname>


#. 创建

   vboxmanage snapshot 虚拟机名称/UUID take 快照名

   

#. 恢复

   vboxmanage snapshot restore 虚拟机名称/UUID

#. 删除

   vboxmanage snapshot delete 虚拟机名称/UUID

#. 修改
