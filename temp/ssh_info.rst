==========
 SSH 说明
==========

- 根据私钥计算公钥 ``ssh-keygen -y -f ./id_rsa``

- 使用指定私钥进行验证

  ::

     # 在 .ssh 中添加配置文件 config 并输入如下内容
     # 假定指定私钥名为 coding_net
     Host *
     IdentityFile ~/.ssh/coding_net
