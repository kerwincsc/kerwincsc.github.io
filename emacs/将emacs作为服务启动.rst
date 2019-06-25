============================================================
将emacs作为服务启动
============================================================

以后台方式启动emacs ::

   # emacs --daemon

如果emacs已经打开, 可以用 ``M-x server-start`` ;
这种方法有个缺点: 如果当前的emacs被关闭了, 使用emacsclient打开的窗口也会被关闭;


作为 Linux 服务启动
--------------------------------------------------

Centos7
########################################

systemctl启动脚本 ::

  [Unit]
  Description=Start Emacs daemon
  After=sshd.service

  [Service]
  Type=forking
  User=root
  Group=root
  ExecStart=/usr/local/emacs/start-emacs start
  ExecStop=/usr/local/emacs/start-emacs stop

  [Install]
  WantedBy=multi-user.target


然后添加 ``alias e='emacsclient -nw'`` , 以后就可以直接使用 ``e [file]`` 编辑文件了;

如果想开机启动的话, 就 ``systemctl enable emacsserver.service`` ;

服务器启停脚本 ::

  #!/bin/bash
  set -e

  function check_emacs_status () {
     PID=$(ps -ef | grep "emacs --daemon" | grep -v grep | awk '{print $2}')

     if [ -z "$PID" ]; then
         echo "Emacs 已关闭"
     else
         echo "Emacs 正在运行中"
         exit
     fi
     unset PID
  }

  function start_emacs () {
     echo "Emacs Server Staring ...."
     emacs --daemon >/dev/null 2>&1
  }

  function stop_emacs () {

     PID=$(ps -ef | grep "emacs --daemon" | grep -v grep | awk '{print $2}')
     if [ -z "$PID" ];then
         echo "Emacs 进程不存在, 即将退出"
         exit
     else
         echo "Emacs Server Stopping ...."
         kill -9 $PID
         return 0
     fi
     unset PID
  }

  case $1 in
     start)
         start_emacs
         echo OK
         ;;
     stop)
         stop_emacs
         ;;
     restart)
         echo "Emacs Server Restarting ...."
         stop_emacs
         start_emacs
         echo "Restarting OK"
         ;;
     status)
         check_emacs_status
         ;;
     *)
         echo "Useage: start | stop | restart | status"
  esac

FAQ
########################################

#. *.emacs* 配置文件没有被加载:
   像上面所说的进行配置, ``emacs --daemon`` 并不会加载我们的配置文件;
   但是命令行中, 此命令是加载root的.emacs配置的;

   使用 ``emacs --daemon --load /root/.emacs`` 或
   ``emacs --daemon --user root`` 直接在命令行启动, 会正常加载root的 *.emacs* 配置文件;

   解决方法(dirty-hack):

     emacsclient [File]

     M-x load-file <RET> ~/.emacs <RET>


作为 wins 服务启动
------------------------------------------------------------

在任务计划中添加执行 ``runemacs.exe --daemon`` 的项;
:download:`下载并导入到计划任务中<./download/打开emacs daemon模式.xml>`

这样, 当系统启动后, 就会自动执行此任务; 如果进程意外退出, 在每天的 7:30 会再次启动;

将 **Edit with Emacs** 集成到右键中,
:download:`下载并导入到注册表中<./download/edit_with_emacs.reg>`

此注册表文件中, **command** 值后面的 ``%1`` 加双引号是为了防止文件名中有空格,
导致文件打开错误;
