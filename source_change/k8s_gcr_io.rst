================
 k8s_k8s.gcr.io
================

对于 kubernetes 相关的镜像, 会使用到 k8s.gcr.io 开头的镜像

k8s.gcr.io 等价于 gcr.io/google-containers, 因此同上也可以使用中科大镜像或者 Azure 中国镜像

中科大镜像
==========

如果我们拉取的 kubernetes google 镜像是以下形式: docker pull k8s.gcr.io/xxx:yyy

相当于 docker pull gcr.io/google-containers/xxx:yyy

那么使用中科大镜像, 应该是这样拉取:

``docker pull gcr.mirrors.ustc.edu.cn/google-containers/xxx:yyy``

Azure 中国镜像
==============

将地址替换为 gcr.azk8s.cn

``docker pull gcr.azk8s.cn/google-containers/xxx:yyy``

