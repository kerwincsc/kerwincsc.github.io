============
 Docker Hub
============

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
     
