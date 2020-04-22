Emacs 便携化
============

#. 进入 ``share/emacs/site-lisp/``;

#. 新建文本文档, 命名为 **site-start.el**;

#. 复制粘贴以下文本并保存

   .. code-block:: lisp

      (defvar program-dir
      (replace-regexp-in-string "share/emacs.*/etc/$" "home/" data-directory :from-end))
      (setenv "HOME" program-dir)
      (load "~/.emacs.d/init.el")

#. 回到 emacs 主目录, 新建文件夹 ``home``;

#. 在 **home** 中新建 ``.emacs.d`` 文件夹;

#. 在 **.emacs.d** 中新建空文件 ``init.el`` 即可;

后续 emacs 的配置就在此 init.el 中生成;
