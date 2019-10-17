================
 Linux 时间调整
================

chrony
======

- 找到合适的 `时间服务器地址`_


- 打开 **chrony.conf** 配置文件, 修改为以下内容

  .. code-block:: shell

     server 0.cn.pool.ntp.org iburst
     server 1.cn.pool.ntp.org iburst
     server 2.cn.pool.ntp.org iburst
     server 3.cn.pool.ntp.org iburst

- 重启 chronyd 服务 ``systemctl restart chronyd``


修改时区
========

- 查看当前时区

  .. code-block:: shell

     $ timedatectl

           Local time: Thu 2019-10-17 06:58:45 EDT
       Universal time: Thu 2019-10-17 10:58:45 UTC
             RTC time: Mon 2019-09-09 16:13:29
            Time zone: America/New_York (EDT, -0400)
          NTP enabled: yes
     NTP synchronized: yes
      RTC in local TZ: no
           DST active: yes
      Last DST change: DST began at
                       Sun 2019-03-10 01:59:59 EST
                       Sun 2019-03-10 03:00:00 EDT
     Next DST change: DST ends (the clock jumps one hour backwards) at
                      Sun 2019-11-03 01:59:59 EDT
                      Sun 2019-11-03 01:00:00 EST

- 查看所有时区 ``timedatectl list-timezones``

  找到上海时区 ``timedatectl list-timezones|grep Shanghai``

- **修改时区** ``timedatectl set-timezone Asia/Shanghai``
  
.. 超链接地址
  
.. _时间服务器地址: https://www.pool.ntp.org/zone/asia
