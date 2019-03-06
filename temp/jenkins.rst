Jenkins 部署指南
======================================================================

邮件配置
------------------------------------------------------------

- jenkins 系统自带

  系统管理->系统设置, 找到 **E-mail Notification**, 在 *SMTP server* 处配置发件服务器,
  如, stmp.163.com;

  点开 **Advanced..**, 勾选 **Use SMTP Authentication**,
  填入 User Name, Password 和 SMTP Port ( 填 25 ), 不勾选 **Use SSL**;

  勾选 Test configuration by sending test e-mail,
  在 Test e-mail recipient 填写待接收测试邮件的邮箱地址;

  点击 Test configuration 后, 如果出现
  ``com.sun.mail.smtp.SMTPSenderFailedException: 553 Mail from must equal authorized user``,
  可能是由于在此配置页中, 关于 **Jenkins Location** 中 System Admin e-mail address 的地址
  与当前的发件地址不同而导致, 改成相同的地址即可;

  - 缺点

    只有当构建失败时, 才会发送邮件;
  
- 邮件插件 email-ext

  系统管理->系统设置, 找到 **Extended E-mail Notification**, 其余配置同上;

  特性:

      - 可修改默认的内容类型, 如纯文本或 HTML;
      - 自定义邮件内容;
      - 将构建日志作为附件同时发送;
      - 在发送前后执行一些自自定义脚本;
      - 选择不同的触发器, 根据构建结果向不同的人发送邮件;

- 密码重置

  - cd /var/lib/jenkins/users/<username_一串数字>/
  - vim config.xml // 找到 **<passwordHash>**
  - 将此标签内的内容改为

    ``#jbcrypt:$2a$10$0EHOi7bKJN8nLoqLsXDwpuv/0uuwA5va9FKwdLwCiGo6B9eTrE/zm``
    对应密码 *272299*;

    ``#jbcrypt:$2a$10$T4n98w2l.Zg5aM0Gcza74eEo3XGI/m6rZGEiIO2/iqbp1F.0/Ag3G``
    对应密码 *buzhidao*

  - 完成后重启 jenkins;

  


FAQ
------------------------------------------------------------

- 在 **Source Code Management** 中配置 git 仓库时, 如果服务端未安装 git,
  则可能出现如下提示:

  ::

     Failed to connect to repository : Error performing command: git ls-remote -h ....


- 在通过 **Send files or execute commands over SSH** 构建时,
  假设配置的 *Remote direcotry* 是 /tmp/test, 但在此目录下, 并无文件;

  **Send files or execute commands over SSH** 是通过插件 **publish over SSH** 实现的,
  故 *Remote direcotry* 的 **/** 指的是插件中 **Remote Directory** 配置的远程目录;
  因而, 在插件中配置 **Remote Directory** 时, 最好直接使用根目录;
