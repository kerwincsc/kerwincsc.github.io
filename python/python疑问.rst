python疑问
======================================================================

- 函数里的 ``/`` 形参是什么?

  函数参数最后一个斜线表示该函数只接收位置参数而不接收关键参数,
  但是在Python中并不允许定义这样的函数,
  这样的函数一般是用C语言开发的内置函数或特定对象的方法,
  更加详细的资料可以查阅“Argument Clinic”有关资料;

- 自定义对象的字符串显示时加 ``!r``  ``!s`` 与不加, 有什么区别?

  ::

     class Pair:
         def __init__(self, x, y):
             self.x = x
             self.y = y

	 def __repr__(self):
             return 'Pair({0.x!r}, {0.y!r})'.format(self)

	 def __str__(self):
             return '({0.x!s}, {0.y!s})'.format(self)

     class Pair:
         def __init__(self, x, y):
	     self.x = x                                                                            self.y = y
	 def __repr__(self):                                                                       return 'Pair({0.x}, {0.y})'.format(self)
	 def __str__(self):                                                                        return '({0.x}, {0.y})'.format(self)

  以上两种类的定义中, 加不加 **!r 与 !s** 有什么不同?
