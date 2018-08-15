你好 Guile
======================================================================

1. 交互式地运行 Guile
------------------------------------------------------------

Guile 以其最简单的形式充当 Scheme 编程语言的交互式解释器,
读取并求值用户从终端输入的 Scheme 表达式;
以下是 Guile 和用户间的一个简单交互;
用户的输入出现在 $ 和 *scheme@(guile-user)>* 提示符之后:

::

  $ guile
  scheme@(guile-user)> (+ 1 2 3)                ; add some numbers
  $1 = 6
  scheme@(guile-user)> (define (factorial n)    ; define a function
                         (if (zero? n) 1 (* n (factorial (- n 1)))))
  scheme@(guile-user)> (factorial 20)
  $2 = 2432902008176640000
  scheme@(guile-user)> (getpwnam "root")        ; look in /etc/passwd
  $3 = #("root" "x" 0 0 "root" "/root" "/bin/bash")
  scheme@(guile-user)> C-d
  $


2. 运行 Guile 脚本
------------------------------------------------------------

就像 AWK, Perl, 或者任何一个 shell, Guile [#guile]_  可以解释脚本文件.
Guile 脚本仅仅是一个开头带有一些额外信息 [#extra_info]_ 的 Scheme 代码文件,
这些信息告诉操作系统如何去调用 Guile,
然后告诉 Guile 如何去处理 Scheme 代码;

::

   #!/usr/bin/guile -s
   !#
   (display "Hello, world!")
   (newline)

3. 把 Guile 链接到程序中
------------------------------------------------------------

作为对象库的 Guile 解释器是可获得的,
使用 Scheme 作为一种配置或者扩展语言被链接到应用中;

这是 *simple-guile.c* , 程序源代码将会产生一个完全的 Guile 解释器.
除所有由 Guile 提供的常见的函数外, 它也会提供 *my-hostname* 函数.

::

   #include <stdlib.h>
   #include <libguile.h>
   
   static SCM
   my_hostname (void)
   {
     char *s = getenv ("HOSTNAME");
     if (s == NULL)
       return SCM_BOOL_F;
     else
       return scm_from_locale_string (s);
   }

   static void
   inner_main (void *data, int argc, char **argv)
   {
     scm_c_define_gsubr ("my-hostname", 0, 0, 0, my_hostname);
     scm_shell (argc, argv);
   }
   
   int
   main (int argc, char **argv)
   {
     scm_boot_guile (argc, argv, inner_main, 0);
     return 0; /* never reached */
   }

当 Guile 被正确地安装在你的系统上时, 上面的程序能够被编译并且链接如下 [#link]_ :

::

   $ gcc -o simple-guile simple-guile.c `pkg-config --cflags --libs guile-2.2`

当其运行时,除了你也能调用新的 *my-hostname* 函数之外, 它表现得就像 *guile* 程序;

::

   $ ./simple-guile
   scheme@(guile-user)> (+ 1 2 3)
   $1 = 6
   scheme@(guile-user)> (my-hostname)
   "burns"

4. 编写 Guile 扩展
------------------------------------------------------------

你能把 Guile 链接到你的程序中并且让你程序的用户可获得 Scheme .
你也能把你的库链接到 Guile 中并且让 Guile 的所有用户可获得它的功能.

链接进 Guile 的库被称作一个 *扩展*, 但它实际上只是一个普通的对象库;

下面的例子将展示如何为 Guile 写一个简单的扩展,
来让 Scheme 代码可获得 *j0* 函数; ::

  #include <math.h>
  #include <libguile.h>

  SCM
  j0_wrapper (SCM x)
  {
    return scm_from_double (j0 (scm_to_double (x)));
  }

  void
  init_bessel ()
  {
    scm_c_define_gsubr ("j0", 1, 0, 0, j0_wrapper);
  }

这段 C 源文件需要被编译成一个共享库. 在 GNU/Linux 中可以这么做: ::

  gcc `pkg-config --cflags guile-2.2` -shared -o libguile-bessel.so -fPIC bessel.c

关于创建可移植的共享库, 我们推荐使用 *GNU Libtool*;

共享库可以通过 *load-extension* 函数被载入一个正在运行中的 Guile 进程.
然后 *j0* 就可立即使用了: ::

  $ guile
  scheme@(guile-user)> (load-extension "./libguile-bessel" "init_bessel")
  scheme@(guile-user)> (j0 2)
  $1 = 0.223890779141236

寻找更多如何安装你的扩展的信息, 参考 `Installing Site Packages`_

5. 使用 Guile 模块系统
------------------------------------------------------------

Guile 支持将一个程序划分进 *模块* 里.
通过使用模块, 你能够把相关代码分组并且从大规模地独立部分管理完整程序的作品;

更多关于模块系统的详细信息超出了这个引导资料, 参考 Modules_ ;

5.1 使用模块
++++++++++++++++++++++++++++++++++++++++++++++++++

Guile 带有许多有用的模块, 例如关于字符串处理或者命令行解析.
此外, 也存在许多由其他 Guile 黑客编写的 Guile 模块,
但是必须手动安装;

这个简单的交互式会话展示了如何使用模块(ice-9 popen),
此模块与提供 *read-line* 函数的模块(ice-9 rdelim)共同提供了在管道上与其它进程通信的方法
::

   $ guile
   scheme@(guile-user)> (use-modules (ice-9 popen))
   scheme@(guile-user)> (use-modules (ice-9 rdelim))
   scheme@(guile-user)> (define p (open-input-pipe "ls -l"))
   scheme@(guile-user)> (read-line p)
   $1 = "total 30"
   scheme@(guile-user)> (read-line p)
   $2 = "drwxr-sr-x    2 mgrabmue mgrabmue     1024 Mar 29 19:57 CVS"

------------------

.. [#guile] 像是 "跪了" 的发音, 哈哈!
.. [#extra_info] 像是 bash 脚本的开头有 **#/usr/bin/bash** 一样,
		 但 Guile 脚本有所不同;
.. [#link] 编译需要 *libguile.h* 库, 需要安装 *compat-guile18-devel* ,
	   根据版本不同, 将 18 换成相应版本号;
	   编译时需要 *--libs guile-2.2* 也要需要换成相应版本号, 如 1.8;

.. _`Installing Site Packages`: https://www.gnu.org/software/guile/docs/docs-2.0/guile-ref/Installing-Site-Packages.html#Installing-Site-Packages

.. _Modules: https://www.gnu.org/software/guile/docs/docs-2.0/guile-ref/Modules.html#Modules
