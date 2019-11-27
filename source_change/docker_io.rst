===========
 docker.io
===========

永久改变
========

对于使用 systemd 的系统 (Ubuntu 16.04+, Debian 8+, CentOS 7),
在配置文件 /etc/docker/daemon.json 中加入

.. code-block:: shell

   {
       "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn/"]
   }

重新启动 docker ``systemctl restart docker``

- 快捷脚本

  .. code-block:: shell

     if [ -f /etc/docker/daemon.json ];\
     then echo /etc/docker/daemon.json exists;\
     else echo -e "{\n    \"registry-mirrors\": [\"https://docker.mirrors.ustc.edu.cn/\"]\n}";
     fi
     
临时使用
========

使用中科大镜像
--------------

如果我们在 docker 官方仓库拉取的镜像是以下形式: docker pull xxx:yyy

那么使用中科大镜像, 应该是这样拉取
``docker pull docker.mirrors.ustc.edu.cn/library/xxx:yyy``

如果我们在docker官方仓库拉取的镜像是以下形式: docker pull xxx/yyy:zz

那么使用中科大镜像，应该是这样拉取
``docker pull docker.mirrors.ustc.edu.cn/xxx/yyy:zz``

使用Azure中国镜像
-----------------

将拉取地址替换为 **dockerhub.azk8s.cn**, 其余同上;
