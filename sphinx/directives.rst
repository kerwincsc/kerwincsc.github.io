指令
======================================================================

.. rst:directive:: code-block

   .. table:: code-block 选项表
      :widths: auto

      ============================= ======================================================
        选项                        效果                                                  
        **:linenos:**               line numbers [#]_ : 给代码块加上行号                  
        **:lineno-start: x**        行号从数字 x 开始;                                    
        **:emphasize-lines: 3,5**   强调指定行, 比如以上, 第 3 行, 第 5 行将被强调        
        **:emphasize-lines: 3-5**   强调指定行, 比如以上, 第 3-5 行将被强调               
        **:caption: 标题**          编码块的标题, 将显示在块上;                           
        **:name: 名称**             编码块的名称, 不会显示, 但是这个名字可以 **被引用**;  
        **:dedent: 4**              指示代码块可以有 4 个字符的缩进                       
      ============================= ======================================================
              
   .. code-block::
      :linenos:
      :lineno-start: 3
      :emphasize-lines: 3,5
      :caption: 这是一个 code-block 示例
      :name: code-block-example

      echo :linenos:
      echo :lineno-start: 3
      echo :emphasize-lines: 3,5
      echo :caption: 这是一个 code-block 示例
      echo :name: code-block-example
      # 加 dedent 选项可能会出现 "检测到过度的去缩进" 原因不明
      echo :dedent: 4 # 这个选项的作用更多的是为了排版更美观
                 
.. rst:directive:: image

   +-----------+-------------------------------------+
   | 选项      | 效果                                |
   +-----------+-------------------------------------+
   | alt       | 图像不可达, 显示其后的文字          |
   +-----------+-------------------------------------+
   | height    | 高度值/百分比                       |
   +-----------+-------------------------------------+
   | width     | 宽度值/百分比                       |
   +-----------+-------------------------------------+
   | scale     | 图像缩放, 默认 100%, 不缩放         |
   +-----------+-------------------------------------+
   | align     | top/middle/bottom/left/center/right |
   +-----------+-------------------------------------+
   | target    | 文本 ( url / 引用名 )               |
   +-----------+-------------------------------------+
   | name      | 常规项, 标识名字用于 ref            |
   +-----------+-------------------------------------+
   | **class** | 常规项                              |
   +-----------+-------------------------------------+

.. rst:directive:: table

   .. table:: table 指令属性表
      :widths: auto

      ========= =============================================
      可选项    属性
      align     left / center / right
      widths    auto / grid / 整形数字列表
      width     当前行宽度的百分比或长度值, 是数字
      **class** 常规项
      **name**  常规项, 标识名字用于 ref
      ========= =============================================

.. rst:directive:: csv-table

   .. csv-table:: csv-table 选项
      :header: 可选项, 说明, 备注
      :widths: 10, 60, 30

      widths, "宽度值 [, 宽度值 ] | auto",
      width, 强行指定行的宽度或指定为当前行宽度的百分比,
      header-rows, 数字值; 用作行标题的行数; 默认是 0,
      stub-columns, 数字值; 用作列标题的列数; 默认是 0,
      header, CSV 格式的数据, "比如 **标题1, 标题2, 标题3** "
      file, 字符串, 不会使用
      url, 去除了空白符的字符串; 指向 CSV 数据文件的互联网 URL引用, 不会使用
      encoding, 文本编码名; 外部 ( file/url ) CSV 数据的文本编码; 默认是文件编码
      delim, 单字符 | "tab" | "space"; 默认是 **逗号**,
      quote, 单字符; 用于引用包含分隔符或以引号字符开头的元素; 默认是 **"**,
      keepspace, flag; 将紧跟在分隔符后面的空白视为重要; 默认情况是忽略这些空白,
      escape, 单字符; 用于转义分隔符或引用; 默认值是将字符加倍, 不会使用
      align, "left, center, right",
      "name, class", 常规项,


.. rst:directive:: toctree

   .. csv-table:: toctree 选项
      :name: toctree-option-table
      :header: 选项, 说明

      caption, "给 ( 图片, 照片等 ) 加说明文字"
      name, 提供 可以通过 ref 使用引用的隐式目标名
      titlesonly, "只想显示树中文档的标题, 而不是同一级别的其他标题"
      glob, 想要模糊匹配的, 就加上
      self, "代表包含 toctree 指令的文档. 如果要从toctree生成站点地图, 将非常用"
      reversed, 反转列表中条目的顺序
      hidden, "仍将通知 Sphinx 文档层次结构, 但不会在指令的位置插入文档中的链接 [#hidden]_"
      includehidden, 如果只想拥有一个顶级 toctree 并隐藏所有其他较低级别的 toctree
      numbered, "想在 HTML 输出中有节号, 请给顶级的 toctree 一个 numbered 选项"
      
.. rst:directive:: glossary

   该指令 **必须包含带有 term 和 term 的释义的** reST 定义列表标记.
   然后,  这些定义可以用 term 角色引用;

   .. code-block::

      .. glossary::

         environment
            A structure where information about all documents under the root is
            saved, and used for cross-referencing.  The environment is pickled
            after the parsing stage, so that successive runs only need to read
            and parse new and changed documents.

         source directory
            The directory which, including its subdirectories, contains all
            source files for one Sphinx project.

   与常规定义列表相比, 每个条目允许多个术语, 并且允许使用内联标记. 您可以链接到所有 term;

   .. code-block::

      .. glossary::

         term 1
         term 2
            Definition of both terms.

   术语表排序时, **第一个术语确定排序顺序**

   如果要为一般索引条目指定 **分组键**, 可以将键设置为 **term : key**

   .. code-block::

      .. glossary::

         term 1 : A
         term 2 : B
            Definition of both terms.

   可以为 glossary 指令提供一个 **:sorted:** 标志, 该标志将按字母顺序自动对条目进行排序;
      
- :index:`index<index_in_section>`

  - 行内

    .. rst:role:: index

       ``- :index:`index<index_in_section>```

       生成名叫 :rst:dir:`index` 的小节, 并在索引页 (index) 生成指向此 index 节
       内容的叫 index_in_section 的索引项;

  - 块级

- **rst:role**

  ::

     .. rst:role:: index

        输出 role -> index

- **rst:dir**

  ::

     .. rst:dir:: .. index:: <entries>

        输出 directive -> .. index:: <entries>




.. rubric:: 备注
.. [#]  number 是拉丁语 numero 的缩写形式, 第一个字母是 N, 最后一个字母是o, 所以缩写成 No.
.. [#hidden] 如果打算自己, 以不同的样式或 HTML 侧边栏插入这些链接, 这是有意义的
