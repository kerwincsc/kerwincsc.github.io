pth文件作用
======================================================================

python中有一个 **.pth** 文件, 该文件的用法是:

  #. 首先xxx.pth文件里面会书写一些路径, 一行一个;

  #. 将xxx.pth文件放在特定位置, 则可以让python在加载模块时,
     读取xxx.pth中指定的路径;

如此一来就可以很简便的书写import语句, 且灵活控制自己写的模块了.
例如:

    先将myproj的路径加入到myproj.pth文件中,
    再讲myproj.pth文件放置在 **__特定目录中__**, 然后再项目的代码中,
    无论哪个目录层级，都可以直接使用:

    ::

       from myproj import conf
       from myproj.lib import xlib

上面提到的 **__特定目录__** 是通过site模块下的 *getsitepackages* 方法获得的,
该方法返回一个路径组成的list:

::

   import site
   site.getsitepackages()

注意, getsitepackages()在不同平台返回不同结果;
