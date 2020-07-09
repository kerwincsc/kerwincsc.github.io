==============
 Emacs 自定义
==============

- 自动匹配括号

  ``M-x package-list-packages RET highlight-parentheses``

  将以下写入配置文件: ``(require 'highlight-parentheses)``

- 自动插入双括号

  开启 ``electric-pair-mode`` 这个 minor mode 后,
  插入左括号会自动补全右括号, 而删除一方括号不会删除另一个.

  默认补全的括号与各个 major-mode 的 syntax table 有关
  ( 可用通过 describe-syntax 查看 ).
  要定义自己的括号列表可用编辑 ``electric-pair-pairs`` 变量

  .. code-block:: elisp

     (setq electric-pair-pairs '(
                                 (?\" . ?\")
                                 (?\{ . ?\})
                                 ) )

- 在指定模式中加载某个模块

  ``(add-hook 'rst-mode-hook 'electric-pair-mode)``
