touch 批量修改文件夹和文件的时间
======================================================================

- 修改文件夹

  .. code-block:: shell

     find ./ -type d -exec touch {} \; 

- 修改文件

  .. code-block:: shell

     find ./ -type f -exec touch {} \;

- 修改全部文件包括文件夹

  .. code-block:: shell

     find ./* -exec touch {} \;
