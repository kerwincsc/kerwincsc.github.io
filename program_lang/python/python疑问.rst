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
       	     self.x = x
	     self.y = y
	 def __repr__(self):
	     return 'Pair({0.x}, {0.y})'.format(self)
	 def __str__(self):
	     return '({0.x}, {0.y})'.format(self)

  以上两种类的定义中, 加不加 **!r 与 !s** 有什么不同?

- python中self和cls的区别

  #. self表示一个具体的实例本身. 如果用了 staticmethod,
     那么就可以无视这个 self, 将这个方法当成一个普通的函数使用;

  #. cls表示这个类本身;

- python中的__init__和__new__的区别

  - __init__ 方法是什么

    __init__ 方法通常用在初始化一个类的 **实例** 的时候

    __init__ 其实不是实例化一个类的时候第一个被调用的方法

  - __new__ 方法是什么

    __new__ 方法接受的参数虽然也是和 __init__ 一样,
    但 __init__ 是在类实例创建之后调用，而 __new__ 方法正是创建这个类实例的方法;

    - __new__的作用

      #. 当你继承一些不可变的 class 时(比如int, str, tuple),
	 提供给你一个自定义这些类的实例化过程的途径;

      #. 实现自定义的metaclass

      #. 实现单例

  - 区别

    #. __init__ 通常用于 ``初始化一个新实例``, 控制这个初始化的过程,
       比如添加一些属性, 做一些额外的操作, 发生在类实例被创建完以后.
       它是 **实例级别** 的方法;

    #. __new__ 通常用于 ``控制生成一个新实例`` 的过程. 它是 **类级别** 的方法


- `Difference between __str__ and __repr__ in Python`_


.. _Difference between __str__ and __repr__ in Python: https://stackoverflow.com/questions/1436703/difference-between-str-and-repr

- 为什么 len 不是普通方法

  我在 2013 年问核心开发者 Raymond Hettinger 这个问题时,
  他用“Python 之禅”里的原话回答了我:"实用胜于纯粹."
  在 1.2 节里我提到过, 如果 x 是一个内置类型的实例, 那么 len(x) 的速度会非常快.
  背后的原因是 CPython 会直接从一个 C 结构体里读取对象的长度, 完全不会调用任何方法.
  获取一个集合中元素的数量是一个很常见的操作, 在 str, list, memoryview 等类型上,
  这个操作必须高效.

  换句话说, len 之所以不是一个普通方法, 是为了让 Python **自带的数据结构** 可以走后门,
  abs 也是同理. 但是多亏了它是特殊方法, 我们也可以把 len 用于自定义数据类型.
  这种处理方式在保持内置类型的效率和保证语言的一致性之间找到了一个平衡点,
  也印证了" Python 之禅" 中的另外一句话:"不能让特例特殊到开始破坏既定规则."
