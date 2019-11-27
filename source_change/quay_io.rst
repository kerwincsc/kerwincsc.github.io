=========
 quay.io
=========

中科大镜像
===

如果我们拉取的 quay.io 镜像是以下形式: docker pull quay.io/xxx/yyy:zzz

那么使用中科大镜像, 应该是这样拉取:

``docker pull quay.mirrors.ustc.edu.cn/xxx/yyy:zzz``

Azure 中国的镜像
===

地址替换为 quay.azk8s.cn, 如下
``docker pull quay.azk8s.cn/xxx/yyy:zzz``
