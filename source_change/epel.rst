==============
EPEL
==============

#. ``sudo yum install -y epel-release``

#. 使用 sed 直接进行替换

   - 更换为中科大源

     .. code-block:: shell

	sudo sed -e 's!^mirrorlist=!#mirrorlist=!g' \
	         -e 's!^#baseurl=!baseurl=!g' \
	         -e 's!//download\.fedoraproject\.org/pub!//mirrors.ustc.edu.cn!g' \
	         -e 's!http://mirrors\.ustc!https://mirrors.ustc!g' \
	         -i /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel-testing.repo


