Python 快速索引
======================================================================

- 计算函数运行时间的装饰器

  .. code-block:: python

     from functools import wraps

     def sum_time(func):

         @wraps(func)
         def wrapper(*args, **kwargs):

             start = time.time()
             func()
             end = time.time()
             print('花费时间: {:.1f} 秒'.format(end - start))

         return wrapper

  如果需要被装饰函数的元信息, 就要使用 wraps, 并将被装饰函数作为参数;

