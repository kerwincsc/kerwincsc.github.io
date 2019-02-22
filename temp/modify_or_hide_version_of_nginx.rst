修改或隐藏Nginx的版本号
======================================================================

- 隐藏版本号

  隐藏 nginx 的版本号很简单, nginx 的 HttpCoreModule 提供了一条叫做 **server_tokens** 指令,
  只要将这条指令设置为 ``server_tokens off`` 就可以了;

- 修改版本号

  需要在配置安装nginx之前进行;
  下载完成 nginx 并解压后, 首先要对源码进行修改, 源码文件都在二级目录 nginx-1.14.2/src/ 下,
  找到如下文件 src/core/nginx.h, 然后再对它进行修改

  .. code-block:: shell

     root@mail nginx-1.14.0]# vi src/core/nginx.h
     
     #define nginx_version         8053
     #define NGINX_VERSION      "10.0"
     #define NGINX_VER          "jh/" NGINX_VERSION
     
     #define NGINX_VAR          "NGINX"
     #define NGX_OLDPID_EXT     ".oldbin"
