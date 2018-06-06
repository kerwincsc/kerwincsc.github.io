========================================================
GPG入门
========================================================

#. 删除密钥

  `gpg --delete-key <UserID>` 这个操作实际上删除公钥的, 如果直接删除公钥, gpg会给提示:

.. hint::
   gpg: there is a secret key for public key "<UserID>"!
   gpg: use option "--delete-secret-keys" to delete it firs

即, 在删除公钥之前, 先删除私钥, 故, 完整的删除一个密钥应该是:

::

  gpg --delete-secret-keys <UserID>;

  gpg --delete-key <UserID>;

如此, 一个密钥才算被完全从本地删除 [#d]_;

#. 输出密钥

公钥文件（.gnupg/pubring.gpg）以二进制形式储存，armor参数可以将其转换为ASCII码显示: ::

 gpg --armor --output public-key.txt --export <UserID>

"用户ID"指定哪个用户的公钥，output参数指定输出文件名


.. rubric:: 备注

.. [#d] 如果遇到<UserID>或者<Email>都相似的项, 删除操作可能会不如预期, 需注意
