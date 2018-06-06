================================================================================
在Emacs中安装sbcl
================================================================================

安装emacs
##########################

1. yum安装: ``yum install emacs -y``;
2. 源码安装不推荐, 真想折腾也行;

安装sbcl
######################################################################

1. 默认软件库里是没有sbcl的, 可以通过安装epel包来解决 `yum install epel-release`;
2. 去官网下载二进制包 [#f1]_

::

 curl -O https://jaist.dl.sourceforge.net/project/sbcl/sbcl/1.4.7/sbcl-1.4.7-x86-64-linux-binary.tar.bz2

 wget https://jaist.dl.sourceforge.net/project/sbcl/sbcl/1.4.7/sbcl-1.4.7-x86-64-linux-binary.tar.bz2


3. 解压安装包

   如果你是最小化安装的话, 这时候你可能会遇到一个问题, 如下所示:

.. hint::
   tar (child): cannot run bzip2: No such file or directory

   tar (child): trying lbzip2

   tar (child): lbzip2: Cannot exec: No such file or directory

   tar (child): Error is not recoverable: exiting now

   tar: Child returned status 2

   tar: Error is not recoverable: exiting now


那么很有可能是没有安装bzip2, ``yum install bzip2 -y``

   解压后, 进入目录找到 **install.sh** , 这就是安装文件了; 

   可以指定安装位置 ``INSTALL_ROOT=/opt/local sh install.sh``,
   如果这样安装, 记得把sbcl的路径加到PATH中;

   默认安装 ``sh install.sh``, 会直接安装到 */usr/local/bin* 下,
   这样就不需要手动添加PATH了;




安装quick-lisp 和 slime
######################################################################

* 下载quick-lisp

  curl -O https://beta.quicklisp.org/quicklisp.lisp

  如果你检查文件完整性的需要, 可一并下载:

  curl -O https://beta.quicklisp.org/quicklisp.lisp.asc

* 安装quick-lisp

  官网有完整的安装示例, 包括验证文件完整性;

::

  $ sbcl --load quicklisp.lisp

  * (quicklisp-quickstart:install)

  * (ql:system-apropos "vecto")

  * (ql:quickload "vecto")

  * (ql:add-to-init-file)

  * (ql:quickload "quicklisp-slime-helper")

  * (quit)

至此, quicklisp安装完成;


整合
######################################################################

在emacs的配置文件中添加: ::

 (setq inferior-lisp-program "sbcl")
 (load (expand-file-name "~/quicklisp/slime-helper.el"))

整合完成, 到此为止就可以在emacs上愉快地使用sbcl了;

.. tip::
   为什么不直接因sbcl? 因为太难用, 说实话, sbcl的交互我不会, 连最基本的移动我都不会;



.. rubric:: 注

.. [#f1] 不要下载源码包, 源码包的安装需要本地已经安装了sbcl;

