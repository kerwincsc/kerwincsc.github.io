==================
 Docker CE 源更换
==================

- `中科大源`_

  .. _中科大源: http://mirrors.ustc.edu.cn/help/docker-ce.html

  安装 Docker CE, 请按照 :doc:`官方安装文档<../k8s/docker_官方安装方法>`,
  选择你对应的系统.
  以 Ubuntu 为例, 参考 官方 Ubuntu 安装 Docker CE 手册 进行安装.

  在阅读官方安装手册时,
  只要把 ``download.docker.com`` 地址换成 ``mirrors.ustc.edu.cn/docker-ce`` 即可.

  CentOS, Fedora 等用户在下载 docker-ce.repo 文件后,
  还需要将该文件中的 ``download.docker.com`` 地址换成 ``mirrors.ustc.edu.cn/docker-ce``
