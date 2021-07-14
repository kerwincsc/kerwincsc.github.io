============
 LaTeX 入门
============

创建书签
========

- 使用 **章节标题** 生成 PDF 书签

  .. code-block:: latex

     \usepackage[colorlinks=true,linkcolor=blue,urlcolor=blue,citecolor=black]{hyperref}


去除章节序号
============

在使用 ``\section{}`` 插入章节后, 如果不想让这个 section 出现自动编号,
我们可以在 \senction{} 的大括号前加上 ``*`` 号, 即 ``\section*{}``,
这样这个 section 不仅不会在正文中被编号,
这个章节也不会在使用 ``\tableofcontents`` 命令的时候被编进目录中;

