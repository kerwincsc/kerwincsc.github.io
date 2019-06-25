处理SecureFX中的中文乱码
======================================================================

在 SecureFX 菜单中选择 :menuselection:`Options --> Global Options…`

在 **Global Options** 窗口中, 选择 :menuselection:`General --> Configuration Path`,
找到 SecureFX 配置文件所在的路径, 并复制该路径;

``Win+E`` 打开文件管理器, 在地址栏中粘贴 SecureFX 配置文件所在的路径,
进入到该目录中, 选择 ``Sessions``;

在 ``Sessions`` 中找到链接地址的 **ini** 文件, 并用文本编辑器打开,
查找: **Filenames Always Use UTF8**, 将 ``Filenames Always Use UTF8`` 
后面的值修改为 **00000001**, 保存退出;
