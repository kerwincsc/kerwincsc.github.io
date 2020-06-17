==============
 ZSH 使用技巧
==============

补全
====

以前杀进程是 ``ps aux | grep xxx`` 查进程的 PID, 然后 ``kill PID``.
有了 zsh, 直接 ``kill xxx`` 然后按下 **tab** 键即可;

别名
====

zsh 不仅支持普通 alias, 还支持针对文件类型的 alias.
如进行以下配置配置

.. code-block:: shell
   :linenos:
   :caption: .zshrc

   alias -s gz='tar -xzvf'
   alias -s tgz='tar -xzvf'
   alias -s zip='unzip'
   alias -s bz2='tar -xjvf'
   alias -s php=vi
   alias -s py=vi
   alias -s rb=vi
   alias -s html=vi
   alias gcid="git log | head -1 | awk '{print substr(\$2,1,7)}' | pbcopy"

配置完毕之后, 在 zsh 下直接输入 xxx.rb, 将自动用 vi 打开;
直接输入xxx.tgz, 将直接按照 tar -xzvf 解压.

最后一个 gcid 将当前 git 项目的第一个 commit 的 id 复制到系统剪切板
( pbcopy 是 Mac 下的复制到系统剪切板命令, linux 请参考相应的发行版更改 ),
在执行 rebase 的时候特别方便;

跳转
====

zsh 的目录跳转更为智能, 你无需输入 cd, 直接输入路径即可.
``..`` 表示后退一级目录,
``../../`` 表示后退两级, 依次类推.( ``...`` 的作用和 ``../../`` 相同 )

输入 ``d``, 将列出当前 session 访问过的所有目录, 再按提示的数字即可进入相应目录;

.. code-block:: shell
   :linenos:

   [kerwin@work ~]$ d
   0   ~
   1   ~/Applications
   2   ~/.proxychains
   3   /opt/homebrew-cask/Caskroom

   [kerwin@work ~]$ 1
   [kerwin@work ~/Applications]$

叹号的用法
==========

  Shell 都支持

  #. ``!!`` 上一条命令

  #. ``!^`` 上一条命令的第一个参数
     
  #. ``!$`` 上一条命令的最后一个参数

  #. ``!*`` 上一个命令的全部参数

  可以按补全, 也可直接执行, zsh 会自动补全, 再去执行.
  bash 的话, 按不会帮你补全.

  .. code-block:: shell

     zsh% echo 1 2 3 4
     1 2 3 4

     "!!"  # echo 1 2 3 4
     "!^"  # 1
     "!$"  # 4
     "!*"  # 1 2 3 4

  非首位参数可以用 ``!:`` 指定

  .. code-block:: shell

     zsh% echo 1 2 3 4
     1 2 3 4

     "!:1"    # 1
     "!:-3"   # echo 1 2 3
     "!:1-1"  # 1
     "!:3-4"  # 3 4

  zsh还支持 ``!?`` 用法, 上面的基本叹号用法只能查找上一个命令的参数.
  这种用法可以更灵活的搜索;

  * **!?<文本>** 在历史命令里查找上一个包含这个文本的命令

  * **!?<文本>?:<$\*::->** 上面的可以补全命令, 如果只需要参数, 可以使用这个

    .. code-block:: shell

       sudo !?mv           # 移动刚才移动失败的文件
       cd !?mkdir?:*<tab>  # 进入刚才的创建的目录

星号的用法
==========

这里的星号是通配符的增强用法, 在 ``*()`` 中添加修饰限定匹配的文件

基本语法:

* m 修改日期

  m 的默认单位是天, 也可以使用小时 h, 周 w, 月 M

  m=minutes,d=days(default)w=week,M=Month +n older than n,-n younger than,
  just n equal to' # N

  - *(m0) 当天修改过的文件
    
  - *(^m0) 当天未修改过的文件

  - *(mh-3) 修改小于3小时的文件

  - *(mw+2) 修改超过两星期的文件
                  
* L 文件大小

  用法未明, ``ls *(L200)``

其它
====

这一部分介绍的是 bash 支持的用法, 而 zsh 默认不支持. 如何去配置, 完成这些功能.

.. code-block:: shell

   C-x C-e    用默认的文本编辑器编辑命令
   M-.        倒序一次遍历命令的最后一个参数
