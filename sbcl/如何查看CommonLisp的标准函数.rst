============================================================
如何查看 Common Lisp 的标准函数
============================================================

如何查看 Common Lisp 的标准函数(这么叫不太准确, 规范的名称似乎是操作符 Symbol);

对于初学者来说, 学习使用 Lisp 有一点很不习惯的地方就是不知道怎么查帮助, 
比如想了解下 Lisp 有哪些自带的函数(C-c C-d h 调用了 slime-hyperspec-lookup), 
后来终于慢慢知道怎么查了, 发现查起来不太方便, 还需要联网. 

其实只要把 HyperSpec 文档下载回来, 解压后直接用浏览器打开就可以查了, 
这个文档本身就提供好几种索引方式, 查起来很方便. 

HyperSpec 由 LispWorks 维护 www.lispworks.com

HTML版本在这里:  http://www.lispworks.com/documentation/common-lisp.html 

下载包在这里: ftp://ftp.lispworks.com/pub/software_tools/reference/HyperSpec-7-0.tar.gz

如果你已经把 HyperSpec 文档包下载回来了, 不想每次查询都要继续通过网络, 那怎么办呢？

办法也很简单, 打开 slime 的目录, 找到里面这个文件 hyperspec.el 修改其中的第4行代码, 用locate命令搜索一下hyperspec.el文件的位置, 原来的代码如下: ::

    (defvar common-lisp-hyperspec-root  
        "http://www.lispworks.com/reference/HyperSpec/"  
        "The root of the Common Lisp HyperSpec URL.  
    If you copy the HyperSpec to your local system, set this variable to  
    something like \"file:/usr/local/doc/HyperSpec/\".")  

只要修改成你当前存放 HyperSpec 的目录即可, 
假设你把 HyperSpec 解压到这里 "/usr/local/doc/HyperSpec/ " 具体修改如下:  ::

    (defvar common-lisp-hyperspec-root  
       "http://www.lispworks.com/reference/HyperSpec/"  
       "The root of the Common Lisp HyperSpec URL.  
    If you copy the HyperSpec to your local system, set this variable to  
    something like \"file:/usr/local/doc/HyperSpec/\".")  
       
    (setf common-lisp-hyperspec-root "file:/usr/local/doc/HyperSpec/")

这样设置就OK了, 执行查询使用 C-c C-d h ,
就会直接用浏览器来打开你存储在本地的 HyperSpec 页面. 

如果你的 Emacs 安装了 W3M, 就直接在 Emacs 里打开了.

BTW, 真是不看不知道, 一看吓一跳, Common Lisp 居然有978个扩展操作符......

.. rubric:: 抄自此处 https://blog.csdn.net/ydt_lwj/article/details/9092739
