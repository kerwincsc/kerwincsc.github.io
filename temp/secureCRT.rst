======================
 SecureCRT 命令行参考
======================

.. csv-table:: 标准命令行选项 ( 常用 )
   :header: "标准选项", "参数", "描述"

   "/N", "tabname", "在 tab 上显示指定名称"
   "/TITLEBAR", "用来显示的标题", "将标题名设置为指定名称"
   "/NOMENU", , "隐藏菜单栏"
   "/NOTOOLBAR", , "隐藏工具栏"
   "/POS", "x y", "指定 SecureCRT 初始位置, x y代表了左上角的像素"

.. csv-table:: 指定协议的命令行选项 ( 常用 )
   :header: "协议选项和必要参数", "相关选项和参数", "描述"

   "/SSH2 [ssh_options] hostname", "none", "以 SSH2 协议连接到指定主机"
   "", "[/AUTH method]", "指定可被接受的鉴权方法 (/AUTH password,publickey, keyboard-interactive, gssapi)"
   "", "[/ENCRYPTEDPASSWORD password]", "指定一个以 SecureCRT 形式加密后的密码"
   "", "[/I identityfile]", "指定私钥文件位置"
   "", "[/L username]", "指定用户名"
   "", "[/P port]", "端口"
   "", "[/PASSWORD password]", "密码"

举例:

.. code-block::

   SecureCRT.exe [/POS 100 50] /SSH2 /L root /PASSWORD 123456 172.31.225.222
