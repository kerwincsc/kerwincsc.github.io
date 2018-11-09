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

5.2 编写新的模块
++++++++++++++++++++++++++++++++++++++++++++++++++

你可以用句法形式 *define-module* 创建新的模块.
到下一个 *define-module* 为止, 所有的跟在这个形式后面的定义将被放进新的模块里.

一个模块通常放在某个文件里, 并且那个文件被安装在一个 Guile 能自动找到它的位置上.
下面是示例 ::

  $ cat /usr/local/share/guile/site/foo/bar.scm

  (define-module (foo bar)
    #:export (frob))

  (define (frob x) (* 2 x))

  $ guile
  scheme@(guile-user)> (use-modules (foo bar))
  scheme@(guile-user)> (frob 12)
  $1 = 24

寻找更多如何安装你的扩展的信息, 参考 `Installing Site Packages`_ ;

5.3 把扩展放进模块里
++++++++++++++++++++++++++++++++++++++++++++++++++

除 Scheme 代码之外, 你也能把以 C 定义的东西放进模块里;

你可以通过编写一个小的定义模块的 Scheme 文件来做到,
并且直接在模块体内调用 *load-extension* ; ::

  $ cat /usr/local/share/guile/site/math/bessel.scm

  (define-module (math bessel)
    #:export (j0))

  (load-extension "libguile-bessel" "init_bessel")
  
  $ file /usr/local/lib/guile/2.2/extensions/libguile-bessel.so
  … ELF 32-bit LSB shared object …
  $ guile
  scheme@(guile-user)> (use-modules (math bessel))
  scheme@(guile-user)> (j0 2)
  $1 = 0.223890779141236

更多信息请参考 `Modules and Extensions`_ ;

6 报告 Bug
------------------------------------------------------------

有关安装的任一问题报告给 bug-guile@gnu.org.

如果你在 Guile 中找到一个 bug , 请把它报告给 Guile 的开发者们, 这样他们能修复它.
当你不可能应用 Bug 修复或者安装一个新版本的 Guile 时, 他们也许能给出应变措施.

在提交 Bug 报告之前, 请检查接下来的列表以确保你真地找到了一个 Bug .

  #. 每当文档和实际行为不同时，您肯定在文档或程序中发现了一个 bug .
  #. 当 Guile 崩溃时;
  #. 当 Guile 永远在完成一个任务时;
  #. 当计算产生错误结果时;
  #. 当 Guile 为合法的 Scheme 程序发出错误信号时;
  #. 当 Guile 没有为非法的 Scheme 程序发出错误信号时, 这有可能是一个 bug,
     除非被明确说明;
  #. 当文档的某些部分不明确并且甚至在你重新阅读那个部分后仍然让你不能理解,
     这也是 bug [#bug]_ ;

在你报告 bug 之前, 请检查一些你加载到 Guile 里的程序
是否设定了一些可能会影响 Guile 功能的变量, 包括你的 *.guile* 文件;
同时, 看看刚刚启动的没有载入你的 *.guile* 文件的 Guile 是否有问题发生
(带有 *-q* 选项启动 Guile以防止加载那个初始化文件).
如果问题没有发生, 你得报告你加载进 Guile的任何程序的准确内容, 以便复现问题;

当你编写 bug 报告时, 请确保在报告中包含如下信息.
如果你不能弄明白一些项, 也没关系, 但是我们获得的信息越多,
我们能诊断并修复 bug 的可能就越高.

  #. Guile 的版本号. 你可以在你的 shell 上调用 ``guile --version``
     或者在 Guile 内调用 ``(version)`` 来获取此信息;

  #. 你的机器类型可被 ``config.guess`` shell 脚本确定.
     如果你检查 Guile, 就会发现此文件在 *build-aux* 中;
     此外, 你能从 http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD 获取最新版本 [#config.guess]_. ::

       $ build-aux/config.guess
       x86_64-pc-linux-gnu

  #. 如果你从一个二进制包安装 Guile, 那个包的版本就是.
     在使用 RPM 的系统上, 使用 ``rpm -qa |grep guile``.
     在使用 DPKG 的系统上, ``dpkg -l | grep guile`` .

  #. 如果你自行编译 Guile, 附上你使用的编译配置: ::

       $ ./config.status --config
       '--enable-error-on-warning' '--disable-deprecated'...

  #. 如何复现 bug 的完整描述.

     假设你有一个产生了 bug 的 Scheme 程序, 请把它包含到 bug 报告里.
     如果你的程序太大而无法包含, 请尝试将代码减少到最小的测试用例.

     如果你能在 REPL 上复现你的问题, 那是最好的, 给出你在 REPL 上输入的表达式.

  #. 不正确行为的描述. 例如, "Guile 进程得到一个致命的信号" 或者
     "输出结果如下, 我哪儿想错了".

     假如 bug 的显示是 Guile 的错误消息, 报告错误消息的精确内容很重要,
     并且回溯将显示那个 Scheme 程序如何到达那个错误的.
     可以在 Guile 的调试器里使用 *,backtrace* 命令做到.

如果你的 bug 引起 Guile 崩溃, 来自底层的调试器(如 GDB)的额外信息将很有帮助.
如果你自行编译了 Guile, 你能够在 GDB 下通过 *meta/gdb-uninstalled-guile* 脚本
运行 Guile. 调用包装脚本而不是像平常一样调用 Guile, 键入 *run* 来启动进程,
然后在崩溃发生时 *backtrace*. 把回溯包含在你的报告中.

------------------

.. [#Guile] 像是 "跪了" 的发音, 哈哈!
.. [#Extra_Info] 像是 Bash 脚本的开头有 **#/usr/bin/bash** 一样,
		 但 Guile 脚本有所不同;
.. [#link] 编译需要 *libguile.h* 库, 需要安装 *compat-guile18-devel* ,
	   根据版本不同, 将 18 换成相应版本号;
	   编译时需要 *--libs guile-2.2* 也要需要换成相应版本号, 如 1.8;
.. [#bug] 写这文档的人真有趣;
.. [#config.guess] 直接 wget 下载, 下载完改名, 或者直接重命名下载,
		   不要直接复制粘贴到 VIM 或 Emacs 中, 会出问题;

.. _`Installing Site Packages`: https://www.gnu.org/software/guile/docs/docs-2.0/guile-ref/Installing-Site-Packages.html#Installing-Site-Packages

.. _Modules: https://www.gnu.org/software/guile/docs/docs-2.0/guile-ref/Modules.html#Modules

.. _`Modules and Extensions`: https://www.gnu.org/software/guile/docs/docs-2.0/guile-ref/Modules-and-Extensions.html#Modules-and-Extensions
