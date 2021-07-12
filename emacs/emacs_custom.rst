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

- 禁止自动备份 ``(setq make-backup-files nil)``

- 字符编码 utf8

  .. code-block:: elisp

     (set-language-environment "UTF-8")
     (set-terminal-coding-system 'utf-8)
     (set-keyboard-coding-system 'utf-8)
     (set-clipboard-coding-system 'utf-8)
     (set-buffer-file-coding-system 'utf-8)
     (set-selection-coding-system 'utf-8)
     (modify-coding-system-alist 'process "*" 'utf-8)
  
- 快捷键设定

  - 全局快捷键

    ``(global-set-key (kbd "键") #'一个命令)``

  - 指定模式快捷键

    ``(define-key '某个mode-map (kdb "键") #'一个命令)``

手动安装 use-package 或在 package-selected-packages 中添加要安装的包,
并使用 ``package-install-selected-packages``

- 安装 ivy

  - 在 package-selected-packages 中添加 ivy

  .. code-block:: elisp

     (use-package ivy
      :ensure t
      :diminish ivy-mode
      :hook (after-init . ivy-mode))


fancy-splash-image 修改启动画面的图片
