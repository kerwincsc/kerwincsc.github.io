========================
 pip 安装软件遇到的问题
========================

当 ``pip install jieba`` 时, 遭遇到 **ModuleNotFoundError: No module named '_ctypes'**
问题;

这是由于缺少开发包导致,
在 CentOS 上, 通过 ``yum install libffi-devel``,
在 Ubuntu 上, 通过 ``apt-get install libffi-dev``,
再重新编译安装 python 即可.

我使用的是 pyenv

.. code-block:: bash

   pyenv uninstall 3.9.2
   pyenv install 3.9.2
