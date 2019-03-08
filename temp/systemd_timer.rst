Systemd 攻略
======================================================================

Timers 定时器单元
------------------------------------------------------------

- 模板

  .. code-block:: shell

     [Unit]
     description=This is the section of description.

     [Timer]
     OnActiveSec=, OnBootSec=, OnStartupSec=, OnUnitActiveSec=, OnUnitInactiveSec=
     OnCalendar=
     AccuracySec=
     RandomizedDelaySec=
     Unit=
     Persistent=
     WakeSystem=
     RemainAfterElapse=

     [Install]
     WantedBy=multi-user.target

- 示例


- `Timer指令详解`_ -> 金步国



.. _Timer指令详解: http://www.jinbuguo.com/systemd/systemd.timer.html
