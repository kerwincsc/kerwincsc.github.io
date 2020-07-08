角色
====

形如 **:rolename:`content`**

- abbr

  缩写.
  如果角色内容包含带括号的解释, 则将对其进行特殊处理:
  它将以 HTML 格式显示在工具提示中, 并在 LaTeX 中仅输出一次;

  .. code-block::

     :abbr:`LIFO (last-in, first-out)`.

  效果如下: :abbr:`LIFO (last-in, first-out)`.

  即, 输出缩写内容, 如果括号中有此缩写的解释, 在鼠标指向时会显示其解释内容;
