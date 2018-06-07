============================================================
将emacs作为服务启动
============================================================

以后台方式启动emacs ::

   # emacs --daemon

如果emacs已经打开, 可以用 ``M-x server-start`` ;
这种方法有个缺点: 如果当前的emacs被关闭了, 使用emacsclient打开的窗口也会被关闭;


作为Linux上的服务启动
--------------------------------------------------

Centos7
########################################

systemctl启动脚本 ::

    [Unit]
    Description=Start emacs in server.
    
    [Service]
    Type=forking
    ExecStart=/usr/bin/emacs --daemon
    ExecStop=/usr/bin/kill -15 `ps -ef | grep 'emacs --daemon' | awk '{print $2}'`
    [Install]
    WantedBy=multi-user.target

.. warning::
   如果 **ExecStop** 中的命令太长, 最好做成脚本;
   否则, `systemctl status emacsserver.service` 会看到一个报警: ::

       Jun 07 10:48:43 work systemd[1]: [/usr/lib/systemd/system/emacsserver.service:9] Trailing garbage, ignoring.


然后添加 ``alias e='emacsclient -nw'`` , 以后就可以直接使用 ``e [file]`` 编辑文件了;

如果想开机启动的话, 就 ``systemctl enable emacsserver.service`` ;
