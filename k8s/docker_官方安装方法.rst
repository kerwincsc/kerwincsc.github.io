===========================
 Docker CE `官方安装文档`_
===========================

CentOS
======

设置软件库
----------

#. 安装依赖包

   .. code-block:: shell

      $ sudo yum install -y yum-utils device-mapper-persistent-data lvm2

   - ``yum-utils`` 提供 ``yum-config-manager`` 工具

   - ``device-mapper-persistent-data`` 和 ``lvm2`` 被 **devicemapper** 存储驱动依赖.

#. 设置 stable 软件库

   .. code-block:: shell

      $ sudo yum-config-manager \
             --add-repo \
	     https://download.docker.com/linux/centos/docker-ce.repo

#. 开启 / 关闭 nightly 或 test 库

   .. code-block:: shell

      $ sudo yum-config-manager --enable docker-ce-nightly
      
   .. code-block:: shell

      $ sudo yum-config-manager --enable docker-ce-test

   .. code-block:: shell
		   
      # 关闭 nightly 库
      $ sudo yum-config-manager --disable docker-ce-nightly


安装社区版 Docker 引擎
----------------------

#. 安装最新稳定版

   .. code-block:: shell
		   
      $ sudo yum install docker-ce docker-ce-cli containerd.io

#. 安装指定版

   .. code-block:: shell

      $ yum list docker-ce --showduplicates | sort -r

      docker-ce.x86_64    3:19.03.1-3.el7   docker-ce-stable
      docker-ce.x86_64    3:19.03.0-3.el7   docker-ce-stable
      docker-ce.x86_64    3:18.09.9-3.el7   docker-ce-stable
      docker-ce.x86_64    3:18.09.8-3.el7   docker-ce-stable
      docker-ce.x86_64    3:18.09.7-3.el7   docker-ce-stable
      docker-ce.x86_64    3:18.09.6-3.el7   docker-ce-stable 




.. _官方安装文档: https://docs.docker.com/install/linux/docker-ce/centos/
