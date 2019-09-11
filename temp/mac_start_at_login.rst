====================
 Mac 自启动项的管理
====================

系统偏好设置
============

添加或移除启动程序, 可以直接在偏好设置修改.

首先, 需要进入 **系统偏好设置**;

然后进入 **用户与群组**;

切换到 **登录项**, 在这里可以添加或移除登录项;

但有时候, 我们会发现有些自启动的软件在这里面是找不到的,
比如 Adobe Creative Cloud 和向日葵. 这个时候我们可以通过终端程序查找.

MacOS 系统的启动项会以 ``.plist`` 的文件存在于以下目录中:

- ``/Library/LaunchDaemons``: 系统启动时, 用户不登录也会运行;
- ``/Library/LanuchAgents``: 用户登录后运行;
- ``~/Library/LaunchAgents``: 用户自定义的用户启动项;
- ``/System/Library/LaunchDaemons``: 系统自带的启动项;
- ``/System/Library/LaunchAgents``: 系统自带的启动项;

每个 .plist 文件中, 有 3 个属性控制着是否会开机自启动.

- ``KeepAlive``: 决定程序是否需要一直运行, 如果是 ``false``, 则需要时才启动, 默认是 ``false``
  
- ``RunAtLoad``: 开机时是否运行. 默认是 ``false``;

- ``SuccessfulExit``: 此项为 ``true`` 时, 程序正常退出时重启 ( 即退出码为 0 );
  为 ``false`` 时, 程序非正常退出时重启.
  此项设置会隐含默认 ``RunAtLoad = true``, 因为程序需要至少运行一次才能获得退出状态;

所以针对这三项, 不同的值有不同的表现:

- 如果 ``KeepAlive = false``:

  - 当 ``RunAtLoad = false`` 时: 程序只有在需要的时候运行;

  - 当 ``RunAtLoad = true`` 时: 程序在启动时会运行一次, 然后等待在有需要的时候运行;

  - 当 ``SuccessfulExit = true /false`` 时, 不论
