============
 pyenv 说明
============

安装
====

如若安装不成功, 请 `参考`_ 最新说明, 并予以更新;

- 安装
  
  .. code-block:: shell
     $ curl https://pyenv.run | bash
     # 等同于下面
     $ $ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

  并在 **~/.bashrc / ~/.zshrc** 中增加以下行
  .. code-block:: shell
     export PATH="$HOME/.pyenv/bin:$PATH"
     eval "$(pyenv init -)"
     eval "$(pyenv virtualenv-init -)"

  安装完成后, 重启 shell;

- 更新

  ``pyenv update``

- 卸载

  pyenv 默认安装在 **$PYENV_ROOT**, 默认情况下是 ``~/.pyenv``,
  故卸载 pyenv 可以直接删除此目录 ``rm -rf ~/.pyenv``,
  并从 *~/.bashrc / ~/.zshrc* 中移除以下行

  .. code-block:: shell
     export PATH="$HOME/.pyenv/bin:$PATH"
     eval "$(pyenv init -)"
     eval "$(pyenv virtualenv-init -)"

换源
====

目前没有可以更换的国内源;
可以采用预先下载 python 源码包的方式加速;


.. _参考: https://github.com/pyenv/pyenv-installer
