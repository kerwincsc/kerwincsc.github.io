支持中文搜索
======================================================================

sphinx-doc 的中文搜索是依靠 **jieba** 这个开源的类库来实现的,
这个类库就支持简体和繁体的切分;

使用
------------------------------------------------------------

#. 系统需要安装 jieba 类库,  ``pip install jieba``

#. 修改 sphinx 的 conf.py 文件, 为项目设置为中文的搜索配置

  ::

     # Language to be used for generating the HTML full-text search index.
     # Sphinx supports the following languages:
     #   'da', 'de', 'en', 'es', 'fi', 'fr', 'hu', 'it', 'ja'
     #   'nl', 'no', 'pt', 'ro', 'ru', 'sv', 'tr', 'zh'
     html_search_language = 'zh'

#. 可选配置

  ::

     # A dictionary with options for the search language support, empty by default.
     # 'ja' uses this config value.
     # 'zh' user can custom change `jieba` dictionary path.
     # html_search_options = {'dict': '/usr/lib/jieba.txt'}   # 根据需要设置jieba的词典路径

#. 接下来重新编译生成文档. ``make html``
