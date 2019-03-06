Jenkins 部署指南
======================================================================



- 在 **Source Code Management** 中配置 git 仓库时, 如果服务端未安装 git,
  则可能出现如下提示:

  ::

     Failed to connect to repository : Error performing command: git ls-remote -h ....


- 在通过 **Send files or execute commands over SSH** 构建时,
  假设配置的 *Remote direcotry* 是 /tmp/test, 但在此目录下, 并无文件;

  **Send files or execute commands over SSH** 是通过插件 **publish over SSH** 实现的,
  故 *Remote direcotry* 的 **/** 指的是插件中 **Remote Directory** 配置的远程目录;
  因而, 在插件中配置 **Remote Directory** 时, 最好直接使用根目录;
