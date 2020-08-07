======
 角色
======

形如 **:rolename:`content`**

.. rst:role:: abbr

   缩写.
   如果角色内容包含带括号的解释, 则将对其进行特殊处理:
   它将以 HTML 格式显示在工具提示中, 并在 LaTeX 中仅输出一次;

   .. code-block::

      :abbr:`LIFO (last-in, first-out)`.

   效果如下: :abbr:`LIFO (last-in, first-out)`.

   即, 输出缩写内容, 如果括号中有此缩写的解释, 在鼠标指向时会显示其解释内容;


.. 不推荐使用的 role
   
.. rst:role:: command

   操作系统级命令的名称, 例如 rm;

   .. code-block::

      :command:`rm`

   如下: :command:`rm`, 和加粗效果相同, 不推荐使用;

.. rst:role:: file
  
   文件或目录的名称. 在内容中, 使用花括号表示 " 变量 " 部分, 例如:

   .. code-block::

      ... is installed in :file:`/usr/lib/python2.{x}/site-packages` ...

   如下: ... is installed in :file:`/usr/lib/python2.{x}/site-packages` ...

   和两个反引号生成的效果相同, 不推荐使用;

.. rst:role:: option

   可执行程序的命令行选项. 这会生成一个指向 option 域的链接 ( 如果存在 )

   示例:

   .. code-block::

      .. option:: -m

         这里是关于 -m 选项的解释

      # 这个 option 角色将会创建 -m 链接, 指向 -m 的 option 域;
      :option:`-m`
