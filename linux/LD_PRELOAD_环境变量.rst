=====================
 LD_PRELOAD_环境变量
=====================

LD_PRELOAD 是个环境变量;

用于动态库的加载;

动态库加载的优先级最高;

一般情况下, 其加载顺序为
``LD_PRELOAD > LD_LIBRARY_PATH > /etc/ld.so.cache > /lib > /usr/lib``
