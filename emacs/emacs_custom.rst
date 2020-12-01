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

- 换行自动缩进

  .. code-block:: elisp

     (global-set-key (kbd "RET") 'newline-and-indent)

- 设置tab缩进

  .. code-block:: shell

     ;; 设置 tab 缩进由 4 个空格代替, 并关闭 tab 缩进 mode
     (setq default-tab-width 4)
     (setq indent-tabs-mode nil)

- 字符编码 utf8

  .. code-block:: elisp

     (set-language-environment "UTF-8")
     (set-terminal-coding-system 'utf-8)
     (set-keyboard-coding-system 'utf-8)
     (set-clipboard-coding-system 'utf-8)
     (set-buffer-file-coding-system 'utf-8)
     (set-selection-coding-system 'utf-8)
     (modify-coding-system-alist 'process "*" 'utf-8)
  


fancy-splash-image 修改启动画面的图片
