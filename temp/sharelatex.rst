=================
 sharelatex 部署
=================

拉取 ShareLaTeX 镜像
====================

``docker pull sharelatex/sharelatex``

启动 sharelatex
===============

``docker-compose up -d <path/to/docer-compose.yml>``

如果提示找不到 docker-compose 命令, 则 ``yum install docker-compose``;

如果不加路径, 则会在当前目录下找 **docker-compose.yml** 文件, 这条我猜的

如有需要, 可以修改 docker-compose.yml 文件, 以自定义镜像文件, 数据存放位置等

- 进入 sharelatex 容器

  ``docker exec -it sharelatex bash``

- 安装完全版 Texlive
  
  .. code-block:: shell

     # 源更换成清华源
     tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet/
     # 更新 tlmgr 自身
     tlmgr update --self
     # 安装完整版
     tlmgr install scheme-full

- 提交 sharelatex 容器

  提交安装了完全版 TexLive 的容器 ``docker commit <container_id> <image_name:tag_name>``

  在 docker-compose.yml 文件中, 将对应的 sharelatex 镜像替换成完全版镜像,
  以免容器停止后所有内容丢失
