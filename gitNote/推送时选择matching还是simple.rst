=============================
推送时选择matching还是simple
=============================

Matching
-----------------------------

‘matching’ 参数是 Git 1.x 的默认行为, 其意是如果你执行 git push 但没有指定分支,
它将 push 所有你本地的分支到远程仓库中对应匹配的分支;

Simple
-----------------------------

Git 2.x 默认的是 simple, 意味着执行 git push 没有指定分支时, 
只有当前分支会被 push 到你使用 git pull 获取的代码;

修改默认设置
------------------------------

从上述消息提示中的解释, 我们可以修改全局配置, 使之不会每次 push 的时候都进行提示.
对于 matching 输入如下命令即可:

::

  git config --global push.default matching


而对于 simple , 请输入:

::

  git config --global push.default simple
