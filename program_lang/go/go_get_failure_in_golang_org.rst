go get golang.org/x 包失败解决方法
======================================================================

由于限制问题, 国内使用 go get 安装 golang 官方包可能会失败;

不翻墙的情况下怎么解决这个问题?
其实 golang 在 github 上建立了一个镜像库,
如 https://github.com/golang/net 即是 https://golang.org/x/net 的镜像库;

获取 golang.org/x/net 包，其实只需要以下步骤:

.. code-block:: shell

   mkdir -p $GOPATH/src/golang.org/x
   cd $GOPATH/src/golang.org/x
   git clone https://github.com/golang/net.git
