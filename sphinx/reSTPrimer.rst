reStructuredText语法入门
===========================================

段落 Paragraphs
++++++++++++++++++++++++++++

在reST文档中, 段落是最基础的块.
段落是由一个或多个空白行分隔的文本块.
就像在python中缩进很重要, 在reST中也是, 所以同一段落的所有的行必须是同级缩进的向左对齐.

行内标记 Inline markup
++++++++++++++++++++++++++++
标准的reST行内标记十分简单:

    * 一星强调(斜体): *text* ,

    * 两星强调(粗体): **text**

    * 两个反引号: ``text`` 代码块

列表和引用块 Lists and Quote-like blocks
+++++++++++++++++++++++++++++++++++++++++++++++
普通列表
----------------------------
列表标记只要在段落的开关放置一个星号并适当缩进即可. 有序列表也一样;
使用 ``#`` 时也能自动顺序标记::

    * This is a bulleted list.
    * It has two items, the second
      item uses two lines.

    1. This is a numbered list.
    2. It has two items too.

    #. This is a numbered list.
    #. It has two items too.

效果如下:

* This is a bulleted list.
* It has two items, the second
  item uses two lines.

1. This is a numbered list.
2. It has two items too.


#. This is a numbered list.
#. It has two items too.

嵌套列表
------------------------------
嵌套列表也可以, 但是要注意其必须与上一级列表之间使用一个空行隔开; 

::

  * this is 
  * a list

    * with a nested list
    * and some subitems

  * and here the parent list comtinues

效果如下:

* this is
* a list

  * with a nested list
  * and some subitems

* and here the parent list continues

定义列表
--------------------------------
定义列表可用如下方式创建 ::

    term (up to a line of text)
        Definition of the term, which must be indented

        and can even consist of multiple paragraphs

    next term
        Description.

term不能有超出一行的文本, 即使用定义列表时, 一行不能太长, 否则可能无法正常显示

效果如下:

term (up to a line of text)
    Definition of the term, which must be indented

    and can even consist of multiple paragraphs

next term
    Description.


行块 Line blocks 
--------------------------------
行块是一种保护行分断的方式

| These lines are
| broken exactly like in
| the source file.

文本块 Literal blocks
+++++++++++++++++++++++++++++

文本代码块通过段落后面跟着特殊的标记符 **::** 引入. 文本代码块必须缩进(并且, 像所有的段落一样, 通过空行分隔周围的段落):


::

  这是正常的段落. 下一行是一个代码示例::

     It is not processed in any way, except
     that the indentation is removed.
       
     It can span multiple lines.

  这又是一个正常段落


``::`` 标记的处理很智能;

  * 如果他出现在它自己的段落, 那个段落将被文档忽略;

  * 如果它出现在空白符之后, 标记符将被移除(隐藏:即实现文本块的功能);

  * 如果它出现在非空白符之后, 标记符将被单个的冒号替换;

这样，上述例子的第一段中的第二句将被呈现为 ``"The next paragraph is a code sample:"`` .

在文档范围的基础上使用 ``highlight`` 指令和在项目范围的基础上使用 ``highlight_language`` 配置选项, 这些文本块的代码高亮将被开启;
``code-block`` 指令可被用来设置逐块基础上的高亮; 具体的后面再谈.


文档测试块 Doctest blocks
+++++++++++++++++++++++++++++
文档测试块是剪切后粘贴到文档字符串中的交互式python会话. 它们不需要 ``literal blocks`` 方法.
文档测试块 **必须以空行结束** 并且不应该以一个未使用的提示符结束.

>>> 1 + 1
2

备注: 如果文档测试块紧跟在标题符后, 可以不使用空行隔开二者;

表 Tables
+++++++++++++++++++++++++++++++++++++++++++++

对于网格表, 你不得不自己 *画*  网格. 它们看上去是这样的:

::

    +------------------------+------------+-----------+-----------+
    | Header row, column 1   | Header 2   | Header 3  | Header 4  |
    | (header rows optional) |            |           |           |
    +========================+============+===========+===========+
    | body row 1, column 1   | column 2   | column 3  | column 4  |
    +------------------------+------------+-----------+-----------+
    | body row 2             | ...        | ...       |           |
    +------------------------+------------+-----------+-----------+

显示如下:

    +------------------------+------------+-----------+-----------+
    | Header row, column 1   | Header 2   | Header 3  | Header 4  |
    | (header rows optional) |            |           |           |
    +========================+============+===========+===========+
    | body row 1, column 1   | column 2   | column 3  | column 4  |
    +------------------------+------------+-----------+-----------+
    | body row 2             | ...        | ...       |           |
    +------------------------+------------+-----------+-----------+



*简易表* 就很容易写了, 但是有限制: 它们必须包括超过一行, 并且第一列不能包含多行.
如下所示:

::

    =====  =====  =======
    A      B      A and B
    =====  =====  =======
    False  False  False
    True   False  False
    False  True   False
    True   True   True
    =====  =====  =======

显示如下:

    =====  =====  =======
    A      B      A and B
    =====  =====  =======
    False  False  False
    True   False  False
    False  True   False
    True   True   True
    =====  =====  =======

还有两种语法支持: *CSV* 表和 *List* 表. 它们使用一种显式的标记块. 更多信息请参考 **表(需要超链接)**

超链接 Hyperlinks
++++++++++++++++++++++++++++++++++

外部链接 External links
----------------------------------

使用`链接描述文本 <https://domain.invalid/>`_启用行内WEB链接.
如果链接描述文本是web地址, 根本就不需要特殊标记, 解析器将会在普通文本中发现链接和邮箱地址.

::

  重要提示

      在链接描述文本和URL的开口符<之间必须要有一个空格.

你也能分开链接和目标定义, 就像这样:::

  This is a paragraph that contain `a link`_.

  .. _a link: https://domain.invalid/

显示如下:

  This is a paragraph that contain `a link`_.

  .. _a link: https://domain.invalid/

备注:

  这种链接可以全部放在文末, 便于组织;

内部链接
------------------------------------

内部链接通过Sphinx提供的一个特殊的reST作用完成, 参考特殊标记部分 `Cross-referrencing arbitrary locations`_.

即在文档的任意位置添加形如 ``.. _your_label_name:`` ,
在需要链接的地方写上 **:ref:`your_label_name`**, 注意: 下划线是必须的;


段落 Sections
+++++++++++++++++++++++++++++++++++++

段落头部通过在段落标题下面以标点字符画线来创建, 至少得和文本一样长: ::

  =================
  This is a heading
  =================

一般说来, 尽管结构是由标题的继承来确定, 仍然没有分配确定的字符给标题分级.
但是你应该遵循此约定 `Python's Style Guide for documenting`_.



    * # 加上划线, 用作片段

    * # 加上划线, 用作章

    * =, 用作节

    * -, 用作子节

    * ^, 用作孙节(子子节)

    * ", 用作段落

当然, 使用自己想要的标记符(参考reST文档), 使用更深层次的嵌套都是你的自由,
但是要记住大多数的目标格式(HTML, LaTeX)有限制地支持深层嵌套.

注: 翻译看看就好, 不要深究, 就是遵循这种顺序而已.

字段列表 Field Lists
+++++++++++++++++++++++++++++++

字段列表是以如下方式标记的字段的序列: ::

    :fieldname: Field content

通常在Python文档中使用它们: ::

  def my_function(my_arg, my_other_arg):
    """A function just for me.

    :param my_arg: The first of my arguments.
    :param my_other_arg: The second of my arguments.

    :returns: A message (just for me, of course).
    """

Sphinx扩展了标准文档工具行为并且解释在文档的开始处的指定的字段列表. 更多信息请参考 `Field Lists`_.

角色 Roles
+++++++++++++++++++++++

一个角色或者"自定义文本解释角色"是一个显式标记的行内片段. 它预示了闭合的文本将会以一种特殊的方式被解释.
Sphinx使用它来提供语义标记和标识符的交叉引用, 如同在适当的部分的描述.
一般语法是: ``:rolename: `content```

文档工具支持以下角色:

    * `emphasis`_-等同于*emphasis*

    * `strong`_-等同于*strong**

    * `literal`_-等同于``literal``

    * `subscript`_-下标文本

    * `superscript`_-上标文本

    * `titile-reference`_-作用于书,期刊和其他材料的标题

参考被Sphinx增加的角色 `Roles`_.

显式标记 Explict Markup
+++++++++++++++++++++++++

在reST中使用"显式标记"处理大多数需要特殊处理的结构, 比如脚注, 特别高亮段, 注释和通用指令.

显式标记块以 ``..`` 后跟空格开始的行开始, 并且由以同级缩进的下一行终结.
(显式标记块和正常段落之间需要一个空行. 这听起来可能有点复杂, 但当你写它时, 它却足够直观.)

指令 Directives
++++++++++++++++++++++++++

指令是显式标记的一个通用块. 和角色(roles)一起, 是reST的延伸机制的一种, 并且Sphinx大量使用它.

文档工具支持以下指令:

  * 警告类(Admonitions):
    attention, caution, danger, error, hint, important, note, tip, `warning`_ 和 generic admonition.
    (大部分的主题仅有"note"和"warning".)

  * 图像类:

    * image(参见下方的 `图像类`_)

    * figure(一种带有标题和可选图例的图像)

  * 额外的体元素:

    * contents(一种本地的, 也就是说, 仅针对当前文件的目录)

    * container(一种带有自定义类, 用于在HTML生成外部<div>标签的容器)

    * rubric(与文档分段无关标题)

    * topic, sidebar(特殊高亮的体元素)

    * parsed-literal(支持内联标记的文本块)

    * epigraph(一个带有可选属性行的区块引用)

    * highlights, pull-quote(带有它们自己的类属性的区块引用)

    * compound(一个复合的段落)

  * 特殊的表:

    * table(带标题的表)

    * csv-table(从逗号分隔值生成的表)

    * list-table(由一列的表生成的表)

  * 特殊指令:

    * raw(包含未加工的目标格式的标记)

    * include(从其它文件包含reStucturedText) - 在Sphinx中,
      当给定一个绝对包含的文件路径, 此指令将其视为与源目录相关.

    * class(给下一个元素分配一个类属性)

  * HTML特性:

    * meta(生成HTML<meta>标签)

    * title(覆盖文档标题)

  * 影响标记:

    * default-role(设定一个新的默认角色)

    * role(创建一个新的角色)

因为这些是仅单个文件的, 设定 `default_role`_ 以更好地使用Sphinx工具.

.. warning::
   不要使用 sectnum, header 和 footer 指令.

由Sphinx添加的 `指令`_ 在这里可以找到.

总的说来, 一个指令由名称, 参数, 选项和内容组成. (记住这个术语, 它将在下一章描述自定义指令中被使用.)
看下面这个例子, ::

  .. function:: foo(x)
                foo(y, z)
     :module: some.module.name

     return a line of text input from the user.

*function* 是指令名. 在这里它被给予两个参数, 第一行剩余的部分和第二行, 还有一个选项 *module*
(正如你所见, 选项在行间被立即给定, 它跟在参数后面并且通过冒号标示.)
选项必须像指令内容一样被同等缩进.

指令内容跟在一个空行之后并且与指令开始相同地被缩进.


图像 Images
+++++++++++++++++++++++++++++++

reST支持如下所示的图像指令: ::

  .. image:: gnu.png
     (options)

当在Sphinx使用时, 给定的文件名(就是这里的gnu.png)必须是与源文件相关的,
或者是绝对的, 这意味着它们是与顶级源目录相关的.
例如,
文件 *sketch/spam.rst* 能够以 *../images/spam.png* 或者 */images/spam.png* 方式引用图像 *images/spam.png* 

Sphinx将自动复制图像文件到在编译时输出目录的子目录(例如, 对HTML输出而言是_static目录).

图像尺寸选项的解释依下列各项: 

  * 如果该尺寸没有单位, 或者说是单位是像素, 给定的尺寸将仅遵从支持像素的输出通道.
    
  * 其他的单位(像是点的 *pt* )将被用来给HTML和LaTeX输出
    (后者(LaTeX)用bp取代pt, 因为这是Tex的单位, 此时72bp=1in).


Sphinx通过允许一个星号的扩展扩展了标准文档工具行为: ::

  .. image:: gnu.*

然后, Sphinx搜索所有的匹配被提供模式的图像并且确定他们的类型.
再然后, 每一个编译器从候选者中选择最好的图像.
例如, 如果文件名 *gnu.** 被给定并且代码树存在两个文件 *gun.pdf* 和 *gnu.png*,
LaTeX编译器会选择前者, 而HTML编译器会选择后者.
支持的图像类型和选择优先级被定义在 `Available builders`_.

注意, 图像文件名不应该包含空格.

版本0.4中的变化: 增加了文件名以星号结尾的支持.
版本0.6中的变化: 图像路径可以是绝对路径.
版本1.5中的变化: LaTeX目标支持像素单位(默认情况下是 96px=1in).


脚注 Footnotes
+++++++++++++++++++++++

对于 *脚注* 而言, 使用[#name]\_来标记脚注的位置,
并且在一个印为红色的"Footnotes"标题之后的文档底部添加脚注主体, 就像下面这样:

::

  Lorem ipsum [#f1]_ dolor sit amet ... [#f2]_

  .. rubric:: Footnotes

  .. [#f1] Text of the first footnote.
  .. [#f2] Text of the second footnote.

你也可以给脚注显式地标号, 或者以不带名字([#]\_)的方式使用自动脚注.

脚注中不可以出现空格;

引用 Citations
+++++++++++++++++++

标准的reST引用以全局的附加特性被支持, 比如, 所有引用能够被所有文件引用.
像下面这样使用它们: ::

  Lorem ipsum [Ref]_ dolor sit amet.

  .. [Ref] Book or article reference, URL or whatever.

引用效果如下:

Lorem ipsum [Ref]_ dolor sit amet.

.. [Ref] Book or article reference, URL or whatever.

引用的用途与脚注相似, 但是引用带着标签, 其不是数字或者不是以#开头.


替换 Substitutions
+++++++++++++++++++++++++

reST支持"替换", 它是文本片段并且/或者是通过|name|在文本内引用的标记.
它们像脚注一样以显式的标记块被定义, 像这样: ::

  .. |name| replace:: replacement *text*

或是这样: ::

  .. |caution| image:: warning.png
               :alt: Warning!


详细内容请参考 `reST reference for substitutioins`_.

如果你想要对所有文档使用一些替换, 就把它们放进 `rst_prolog`_ 或者 `rst_epilog`_
或者把它们放进一个独立的文件
并且使用 **include** 指令把它包含到所有的你想要在它们里面使用的文档.
(确认赋予了include文件一个不同于其他源文件的文件名扩展,
来禁止Sphinx作为一个独立的文档发现它.)

Sphinx定义了一些默认的替换, 详情 `替换`_.


注释 Comments
+++++++++++++++++++++

每一个不是合法标记结构(像上面的脚注)的显式标记块被认为是一个注释. 比如: ::

  .. This is a comment.

你可以在一个注释开始之后缩进文本以形成多行注释: ::

 ..
   This whole indented block
   is a comment

   Still in the comment.

..
    This whole indented block
    is a comment

    Still in the comment.
    虽然这两行在VIM中没有被高亮为注释.
    但仍然是注释.

    除非换行后隔一空行后顶行书写, 注释才结束.


源编码 Source encoding
++++++++++++++++++++++++++

从最开始的时候, 在reST中包含像em [#f1]_ , dashes [#]_ 或者 copyright [#]_ 标识
是直接以Unicode字符写它们, 其不得不指定一个编码.
Sphinx假定源文件默认以UTF-8编码; 你可以用 `source_encoding`_ 配置值来更改它.


陷阱 Gotchas
++++++++++++++++++++++++

当创作文档时, 通常会有一些问题出现:

  * **内联标记的分离**: 正如上面所说, 内联标记跨度必须被周围的非单词字符的文本分隔,
    你不得不使用反斜杠转义空格来绕过它.
    详情请参考 `the reference`_.

  * **没有嵌套的内联标记**: 某些像*see :func:\`foo`\*是不被允许的.



.. ======================脚注区注释=======================

.. rubric:: Footnotes

.. [#f1] 强调

.. [#] 破折号

.. [#] ©

.. =======================链接区注释========================

.. _Cross-referrencing arbitrary locations: Cross-referrencing arbitrary locations/

.. _Python's Style Guide for documenting: Python's Style Guide for documenting/

.. _Field Lists: Field Lists

.. _emphasis: http://docutils.sourceforge.net/docs/ref/rst/roles.html#emphasis

.. _strong: http://docutils.sourceforge.net/docs/ref/rst/roles.html#strong

.. _literal: http://docutils.sourceforge.net/docs/ref/rst/roles.html#literal

.. _subscript: http://docutils.sourceforge.net/docs/ref/rst/roles.html#subscript

.. _superscript: http://docutils.sourceforge.net/docs/ref/rst/roles.html#superscript

.. _titile-reference: http://docutils.sourceforge.net/docs/ref/rst/roles.html#titile-reference

.. _Roles: http://www.sphinx-doc.org/en/master/usage/restructuredtext/roles.html

.. _图像类: 空

.. _default_role: null

.. _warning: http://docutils.sourceforge.net/docs/ref/rst/directives.html#warning

.. _指令: http://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html

.. _Available builders: http://www.sphinx-doc.org/en/master/builders.html#builders

.. _reST reference for substitutioins: http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#substitution-definitions

.. _rst_prolog: http://www.sphinx-doc.org/en/master/usage/configuration.html#confval-rst_prolog

.. _rst_epilog: http://www.sphinx-doc.org/en/master/usage/configuration.html#confval-rst_epilog

.. _替换: http://www.sphinx-doc.org/en/master/usage/restructuredtext/roles.html#default-substitutions

.. _source_encoding: http://www.sphinx-doc.org/en/master/usage/configuration.html#confval-source_encoding

.. _the reference: http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#substitution-definitions
