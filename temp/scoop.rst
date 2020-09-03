================
 scoop 镜像加速
================

使用Gitee

上 Gitee, 导入 github 上的 extras 仓库

在 powershell 里运行

.. code-block:: powershell

   # 这里最好将 extras 改为 extras-in-gitee
   # 当你发现某些软件无法更新时, 就会发现自己用的是 gitee 的源
   # 并且其已过期了
   scoop bucket add extras https://gitee.com/kerwincsc/scoop-extras.git``

可能遇到的问题

.. code-block::

   error: RPC failed; curl 18 transfer closed with outstanding read data remaining
   fatal: the remote end hung up unexpectedly
   fatal: early EOF
   fatal: index-pack failed

解决方法

- 不使用 https, 将其改为 http; 治标

- 究其原因是因为 curl 的 **postBuffer** 的默认值太小,
  我们需要调整它的大小, 在终端重新配置大小

  在这里, 把 postBuffer 的值配置成 500M, 可以根据你需要下载的文件大小,
  将postBuffer 值配置成合适的大小

  ``git config --global http.postBuffer 524288000``

  这样已经配置好了, 如果不确定, 可以根据以下命令查看 postBuffer

  ``git config --list``
