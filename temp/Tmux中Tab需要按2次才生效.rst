Tmux中Tab需要按2次才生效
======================================================================

- 原因经过: tmux默认的prefix键是ctrl-b, 感觉不是很方便, 就设置成了ctrl-i,
  然后发现按Tab要按2下才生效, 退出tmux后Tab就正常,
  改回默认prefix键后Tab键也正常, 查找资料后找到了解决办法;

- 解决方法: 避免出现这个问题请 **不要设置prefix键为ctrl-i** ;

  原因是在终端或终端模拟器中 ctrl-i和Tab的ASCII码是一样的,
  终端认定ctrl-i也是Tab键, 所以才产生了这个问题;

  可以用如下命令查看prefix键映射: ::

    tmux show-options -g | grep prefix  

    tmux list-keys | grep prefix
