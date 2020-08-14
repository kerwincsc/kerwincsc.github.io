======
 EPEL
======

#. ``sudo yum install -y epel-release``

#. 更换为

   - 中科大源

     .. code-block:: bash

        sudo sed -e 's|^metalink=|#metalink=|g' \
                 -e 's|^#baseurl=https\?://download.fedoraproject.org/pub/epel/|baseurl=https://mirrors.ustc.edu.cn/epel/|g' \
                 -i.bak \
                 /etc/yum.repos.d/epel.repo

   - 清华源

     .. code-block:: bash

        sed -e 's!^metalink=!#metalink=!g' \
            -e 's!^#baseurl=!baseurl=!g' \
            -e 's!//download\.fedoraproject\.org/pub!//mirrors.tuna.tsinghua.edu.cn!g' \
            -e 's!http://mirrors\.tuna!https://mirrors.tuna!g' \
            -i.bak /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel-testing.repo
        
