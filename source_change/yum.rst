=============
 更换 yum 源
=============


- CentOS 7

  .. code-block:: bash

     sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \
              -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.ustc.edu.cn/centos|g' \
              -i.bak \
              /etc/yum.repos.d/CentOS-Base.repo

- CentOS 8

  .. code-block:: bash

     sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \
              -e 's|^#baseurl=http://mirror.centos.org/$contentdir|baseurl=https://mirrors.ustc.edu.cn/centos|g' \
              -i.bak \
              /etc/yum.repos.d/CentOS-Base.repo \
              /etc/yum.repos.d/CentOS-Extras.repo \
              /etc/yum.repos.d/CentOS-AppStream.repo

- `其它版本`_

     .. _其它版本: http://mirrors.ustc.edu.cn/help/centos.html

- 运行 ``sudo yum makecache`` 生成缓存.
