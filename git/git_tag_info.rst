==================
 git tag 使用说明
==================

创建
====

附注标签
--------

运行 tag 命令时指定 -a 选项, 即可创建;

.. code-block:: shell

   $ git tag -a v1.4 -m 'my version 1.4'
   $ git tag
   v1.4

**-m** 选项指定了一条将会存储在标签中的信息.
如果没有为附注标签指定一条信息, Git 会运行编辑器要求你输入信息.

轻量标签
--------

创建轻量标签, 不需要使用 -a, -s 或 -m 选项, 只需要提供标签名字.

.. code-block:: shell

   $ git tag v1.4-lw
   $ git tag
   v1.4
   v1.4-lw

后期打标签
==========

可以对过去的提交打标签.

``git tag -a v1.2 <checksum>``

查看标签
========

- 列出已有标签 ``git tag``

- 按特定模式查找标签 ``git tag -l 'v1.8.5*'``

- 附注标签详情

  ``git show v1.4`` 将显示打标签者的信息, 打标签的日期时间, 附注信息,
  然后显示具体的提交信息.

- 轻量标签详情

  ``git show v1.4-lw`` 只显示提交信息, 没有其它额外信息.

共享标签
========

- ``git push origin [tagname]``

  一次推一个 tagname 标签

- ``git push origin --tags``

  将所有不在远程仓库的标签全部传送过去.

检出标签
========

.. code-block:: shell

   $ git checkout -b version2 v2.0.0
   Switched to a new branch 'version2'
  

删除
====

- 本地标签 ``git tag -d <tagname>``

- 远程仓库

  1. ``git push origin :refs/tags/<tagname>``

  2. ``git push origin --delete tag <tagname>`` Git 1.7.0 后推荐使用这个.


  Git 的推送和删除远程标签命令是相同的, 删除操作实际上就是推送空的源标签 refs

  推送某个标签 **git push origin <tagname>** 相当于
  **git push origin refs/tags/源标签名:refs/tags/目的标签名**



标签术语说明
============

- 附注标签 (annotated)

  - 是存储在 Git 数据库中的一个完整对象
    
  - 可以被检验
    
  - 在其中包含打标签者的名字, E-Mail, 日期时间;

  - 标签信息
    
  - 可以使用 GNU Privacy Guard (GPG) 签名与验证

  - 如果不想要 **保存以上信息** 或只想用一个 *临时的* 标签, 可以使用轻量标签.

- 轻量标签 (lightweight)

  是特定提交的引用.

- 共享标签

  默认情况下, git push 命令并不会传送标签到远程仓库服务器上.
  在创建完标签后你必须 **显式地推送标签** 到共享服务器上.

- 检出标签

  在 Git 中不能真的检出一个标签, 因为它们并不能像分支一样来回移动.
  如果想要工作目录与仓库中特定的标签版本完全一样,
  可以使用 ``git checkout -b [branchname] [tagname]``
  在特定的标签上创建一个新分支.
