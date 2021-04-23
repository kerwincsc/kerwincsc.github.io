如何让 firefox 标签页后台打开
======================================================================

即打开页面, 再点击链接, 不会跳到新链接产生的 tab 页面上;

#. 地址栏输入 ``about:config``
#. 找到:
   #. ``browser.tabs.loadDivertedinbackground``
   
   #. ``browser.search.openintab`` 新标签页进行搜索

   #. ``browser.urlbar.openintab`` 新标签页打开地址

   #. ``browser.tabs.loadBookmarksInTabs`` 新标签页打开书签
      
#. 修改为 **True** 即可, 默认为 False;
   即可解决绝大多数链接在新标签页打开 ( 书签, 搜索结果, 网页上的 URL 链接等 )
