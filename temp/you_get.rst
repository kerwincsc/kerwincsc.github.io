You-get 下载优酷资源时遇到错误时的解决办法
======================================================================

- you-get: 客户端无权播放, 201

  - 获取 ``ccode``

    利用抓包软件抓取包含 ccode 的链接; 形如

    ::

       GET /playlist/m3u8?vid=XNDExNTQ2MzM3Ng
       &type=hd&ups_client_netip=b465e362&
       utid=Ks47FI3Ay0gCAbRl42L5rNC4&ccode=0502 <--- 这里
       &psid=c59d438e2307e1198752761f22abd117
       &ups_userid=28931626&ups_ytid=329750308
       &password=xp3498fd
       &app_ver=1.7.2&duration=826&expire=18000&drm_type=1
       &drm_device=7&play_ability=1280&media_type=standard,subtitle
       &ups_ts=1563947555&onOff=0&encr=0
       &ups_key=0c7b4f69db295ce05e69c5473a39a6a1 HTTP/1.1

  - 更改 ``ccode``

    包含该内容的文件位于 **you_get/extractors/youku.py**;

    将 ccode 进行替换;

    接下来, 可能会遇到 **账户异常问题**


- you-get: 用户账户异常, 请重新登录

  - 加上 cookies 即可解决

    如果用的 firefox 浏览器, 搜索 **cookies.sqlite**,
    将包含此文件名的地址附加在命令行后, 例如

    ::

       you-get.exe [url]  [-P ***] -c C:\Users\###\AppData\Roaming\Mozilla\Firefox\Profiles\yhrwab0v.default\cookies.sqlite
