==============
EPEL
==============

#. ``sudo yum install -y epel-release``

#. 更换为中科大源

   .. code-block:: bash

      sudo sed -e 's|^metalink=|#metalink=|g' \
               -e 's|^#baseurl=https\?://download.fedoraproject.org/pub/epel/|baseurl=https://mirrors.ustc.edu.cn/epel/|g' \
               -i.bak \
               /etc/yum.repos.d/epel.repo
