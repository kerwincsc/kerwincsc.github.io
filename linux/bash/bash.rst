BASH
======================================================================

3. Shell 基本特性
------------------------------------------------------------

3.1 shell 语法
++++++++++++++++++++++++++++++++++++++++++++++++++

3.1.1 shell 操作
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

shell 的执行顺序:

#. 从一个文件, 从一个由 **-c** 调用选项提供的字符串, 或者从用户终端读取输入;
#. 遵循引用规则, 将输入分解为单词和运算符;

   这些符号被元字符分隔;别名扩展也在这步执行;

#. 将这些符号解析成简单的且混合的命令;
#. 执行 shell 的变量扩展, 将扩展开的符号分解成文件名, 命令和参数的列表;
#. 执行所有必要的重定向, 然后从参数列表中移除所有的重定向符号和它们操作对象;
#. 执行命令
#. 可选择地等待命令的完成(&), 然后收集它的退出状态;

3.1.2 引用
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

引用是用来移除对 shell 有特殊意义的字符或单词.

引用可被用来取消对特殊字符的特殊对待,
防止保留字被识别和防止参数扩展;

三种引用机制:

- 转义字符 ``\``
  对特定字符进行转义;
  如果一命令命令过长, 需要折行书写, 使用 / 确保是同一行的命令;

- 单引号 ``'``
  以单引号闭合的字符在单引号中保留了每个字符的字面值;
  一个单引号不会出现在单引号之间, 即使它的前面有一个反斜杠;

- 双引号 ``"``

  双引号里的字符将保留其字面值,
  以下除外: ``$ ` \`` 和打开历史展开功能时的 ``!``

  当处于 POSIX 模式中:
    - 即使打开了历史展开功能,
      双引号内的 **!** 也没有特殊意义;
    - 双引号中的'$' 和 '`' 保留自身的特殊意义;
    - 反引号后仅跟着如下符号: '$' , '`', '"', '\' 或者 *newline* 时,
      才保留其特殊意义;
    - 在双引号内, 被这些字符跟随的反斜杠将被移除.
    - 没有特殊意义字符之前的反引号将不作修改(不会被移除).

  在双引号里的一个双引号, 它之前有反引号的可被引用;

  如果打开, 除非出现在双引号内的 '!' 使用反引号逃逸, 否则历史命令展开将被执行;
  在 '!' 之前的反引号不会被移除;

  出现在双引号里的特殊字符 '*' 和 '@' 有特殊的意义;


3.2 shell 命令
++++++++++++++++++++++++++++++++++++++++++++++++++

3.2.1 简单命令
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- 命令的退出状态
  如果命令被信号终止, 则退出状态为 128+信号数;
  比如, 被 Ctrl+c 中止的命令退出状态码是 130(128+2);

3.2.2 管道
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- ``|   |&``
- ``command1 |& command2``
  将 command1 的标准输出和标准错误作为 command2 的输入;
  等同于 **command1 2>&1 | command2** ;
- 标准错误到标准输出的隐式重定向在任一由命令指定的重写向之后被执行;
- time / time -p
  time -p 以 posix 形式输出时间;

  time 在 posix 模式下是没有多余的选项的, 其后跟 **-** 将会报错;

- `TIMEFORMAT` 显示命令的执行时间;

3.2.3 命令列表
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- 命令列表是被 ``; & && ||`` 中的某个分隔的一个或多个管道的序列;
- 列表操作符中, **&&** 和 *||* 优先级相同, *;* 和 *&* 优先级相同;
- 一个或多个换行符的序列可能出现在列表中以分隔命令, 其等价于分号;
- 当作业控制不活动时, 异步命令的标准输入 (在没有任何显式重定向功能的情况下)
  将从 /dev/null 被重定向
- 被 ; 分隔的命令依次被执行;
  shell 轮流等待每个命令去终结;
  最后一个命令的退出状态作为整个命令列表的退出状态;
- and 和 or 列表:
  ``cmd1 && cmd2`` 仅当 cmd1 的退出状态为 0, 才执行 cmd2;

  ``cmd1 || cmd2`` 仅当 cmd1 的退出状态不为 0, 才执行 cmd2;

3.2.4 复合命令
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. 循环构造
******************************

- until

  - ``until test-commands; do consequent-commands; done``
  - 只要 test-commands 的退出状态 *非零* , 就执行;

    直到 test-commands 的状态为 0, 才退出循环;

  - 最后一个命令的退出状态作为整体的返回值, 如果未执行, 就返回 0;

- while

  - ``while test-commands; do consequent-commands; done``
  - 只要 test-commands 的退出状态为 0, 就执行循环; 其余同上;

- for

  - ``for name [ [in [words …] ] ; ] do commands; done``

    - 将 *word* 展开为结果列表, 并为每一个在结果列表中的成员执行一次 *commands* ,
      带有绑定了当次循环成员的 *name* ;
    - 如果 *in word* 未指定, 则每一个位置参数上执行一次,
      就像是 ``for name in "$@"`` ;
    - 退出状态同上;
      
  - ``for (( expr1 ; expr2 ; expr3 )) ; do commands ; done``

    - 类 C 的循环结构
    - expr1 首先被求值;
    - 然后 expr2 被重复求值, 直到求值为 0;
    - expr2 被求值后, 不为 0, 则执行 **commands** ,
      然后对 expr3 求值;
    - 如果任一部分缺失, 则相当于被求值为 1;

      ``for ((;;));do echo hello;done`` 等价于 ``while ; do echo hello; done``

- until, while, for三者基本可互相替换, 并且都需要 do done;

2.  条件构造
******************************

- if

::

    if test-commands; then
      consequent-commands;
    [elif more-test-commands; then
      more-consequents;]
    [else alternate-consequents;]
    fi

   #. *test-commands* 首先被执行, 如果返回状态为 0,
   #. *consequent-commands* 被执行, 如果返回状态不为 0,
   #. 每一个 elif 列表将依次被执行, 如果返回状态为 0, 则执行 *more-consequents* ,
   #. 如果存在 else 列表, 且上面的所有 if 和 elif 的返回状态不为 0, 则执行 *alternate-consequents* ;

- case

::

   case word in [ [(] pattern [| pattern]…) command-list ;;]… esac

  - 有选择执行命令列表;
  - 如果 **nocasematch** [#nocasematch]_ 被启用, 则在不考虑字母字符大小写的情况下执行匹配操作;
  - `|` 被用来分隔多个匹配模式;
  - `)` 被用来终结匹配模式列表;
  - 一个匹配模式列表和与之相关的命令列表构成一个从句
  - 每个从句必须以 ``;;`` , ``;&`` , ``;;&`` 终结.

    - 使用 *;;* , 第一次匹配后, 不会继续向下匹配;
    - 使用 *;&* , 匹配执行后, 执行 ;& 后面的从句(不需要重新匹配, 直接执行), 如果有的话;
    - 使用 *;;&* , 匹配执行后, 执行 ;;& 后的从句的匹配, 如果匹配, 则继续执行;
  - 使用 ``*`` 作为最后的匹配模式以定义默认的情况;
  - 没有一个匹配, 则返回 0, 否则就最后一个命令的退出状态;

- select

::

   select name [in words …]; do commands; done

  - 与 for 几乎相同的语法;
  - *in* 后的 *word* 列表被扩展生成一个项目列表;
  - 展开的 words 集被打印到标准错误输出流上, 且每个前面有一个数字;
  - 如果没有 *in words* , 就会打印位置参数, 就像指定了 *$@* ;
  - PS3 提示被显示, 然后从标准输入读取一行;
  - 输入对应行行前的数字, *name* 的值被设置为那行的词;
  - 如果没输入直接回车, 则会再显示一次数字和词;
  - 如果读取到 *EOF* , 命令终结;
  - 读取到其它的数字值, *name* 的值将为空;
  - 每进行一次选择, *commands* 被执行一次, 除非遇到 *break*,

- ((...))

::

   (( expression ))

  - 与 ``let "expression"`` 完全相同;
  - 如果表达的值 **非0** , 则返回状态为 **0** ; 其它情况返回 **1** ;

- [[...]]

::

   [[ expression ]]

  - 返回状态是 0 还是 1, 取决于条件表达式 *expression* ;
  - 在 *[[ 和 ]]* 之间:

    - 不会执行 *单词分拆* 和 *文件名扩展*;
    - 会执行 *波浪线扩展*, *参数及变量扩展*, *算术扩展*, *命令替换*, *进程替换* 和 *引用移除*;

  - 条件操作符, 如 *-f*, 不能被引用;
  - 当 *<* 和 *>* 与 *[[* 一起使用时, 使用当前字符集的字典序进行排序;
  - 当使用 *==* 和 *!=* 时, 操作符右边的字符串被当成一个模式, 并按照匹配规则进行匹配,
    就好像开启 *extglob* shell 选项;
  - *=* 与 *==* 完全相同;
  - 如果启用了 *nocasematch* shell 选项, 则在不考虑字母字符大小写的情况下执行匹配操作;
  - 如果字符匹配了(==)或者不匹配(!=), 返回值为 0;
  - 模式的任一部分可被引用以强制被引用部分被作为字符串匹配;


  - 另一个二元运算符, *=~* , 可用, 其优先级与 '==' 和 '!=' 相同;
  - 使用时, 运算符右边的字符串被认为是扩展的正则表达式, 然后相应地匹配;
  - 匹配了, 则返回 0, 否则返回 1;
  - 如果正则表达式语法有误, 则条件表达式返回 **2**;
  - 如果启用了 *nocasematch* shell 选项, 则在不考虑字母字符大小写的情况下执行匹配操作;
  - 模式的任一部分可被引用以强制被引用部分被作为字符串匹配;
  - 正则表达式中的括号表达式必须仔细处理, 因为正常的引用字符在括号之间失去其含义;
  - 如果模式存储在 shell 变量中, 引用那个变量扩展强制将整个模式匹配为字符串;
  - 在正则表达式中, 被带括号的子表达式匹配的子字符串被保存在数组数量 *BASH_REMATCH* ;
  - 索引为 0 的 BASH_REMATCH 的元素是匹配了整个正则表达式的字符串的那部分;

    索引为 n, 则是第 n 个括号子表达式匹配的子字符串的那部分;

3. 分组命令
******************************

- 提供两种分组命令
- 当命令被分组时, 重定向功能可以应用于整个命令列表
- ()

::

   ( list )

  - 放在括号间的命令列表将会引发 **子shell** 环境的创建, 然后每个命令列表中的命令将在子 shell 中执行;
  - 因为命令在子shell中执行, 所以命令完成后分配的变量不会保留;

- {}

::

   { list; }

  - 放在大括号中的命令列表将使命令列表在 **当前shell** 中执行;
  - 不会创建子shell;
  - 跟在 *list* 后面的分号(或者换行)是需要的;

- 除了创建一个 subshell, 由于历史原因, 这两种构造之间存在着微妙的差别;
- 大括号是保留字, 因此必须用空格或其他 shell 元字符将它们与列表隔开;
- 括号是运算符, 并且由 shell 识别为单独的标记, 即使它们没有按空格与列表分开;

3.2.5 协程
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- 协程在子shell中异步执行, 就好像命令被 *&* 控制运算符终止,
  并在正在执行的shell和协程之间建立了双向管道;
-  协程形式: ``coproc [NAME] command [redirections]``
   
   - 此命令创建了一个叫 *NAME* 的协程; 如果没有提供 NAME, 默认把 *COPROC* 当作名称;

     如果是简单命令, 就不是一定要提供 NAME ;
     否则, NAME 被解释为简单命令的第一个词;
   - 协程在执行时, shell 在执行中 shell 的上下文中创建一个名为 *NAME* 数组变量;
   - 在执行 shell 中, *command* 的标准输出通过管道被连接到一个文件描述符,
     那个文件描述符被分配给 *NAME[0]* ;

     *command* 的标准输入同上, 其描述符被分配给 *NAME[1]* ;
   - 此管道是在任何由命令指定的重定向之前被建立;
   - 那个文件描述符可被用作 shell 命令的参数和标准字扩展的重定向;
   - 子 shell 中, 那个文件描述符不可获得;

   - 被唤醒用以执行协程的 shell 的进程 ID 可通过 *NAME_PID* 的值获取;
   - 内置命令 *wait* 可用来等待协程终结;

   - 因为协程被创建为一个异步命令, 所以 *coproc* 命令总是返回成功;
   - 协程的退出状态就是命令的退出状态;

3.2.6 GUN Parallel
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

3.3 Shell 函数
++++++++++++++++++++++++++++++++++++++++++++++++++

::

   name () compound-command [ redirections ]
   or
   function name [()] compound-command [ redirections ]


- 在当前的 shell 上下文中执行, 不会创建新的进行解释函数;
- 如果有保留字 *function* , 则 *()* 是可选的;

  同样, 如果有 *()*, 则 *function* 是可选的;
- 如果在 POSIX 模式中, *name* 不能和特殊的内置命令相同;
- 使用内置命令 *unset* 的 *-f* 选项可以删除函数的定义;
- 除非发生了语法错误或者同名的只读函数已经存在, 否则返回状态为 0;

  函数执行后, 退出状态是函数体中最后一个命令的退出状态;
- 请注意, 出于历史原因 [#hist_reason]_ , 在最常见的用法中, 函数体周围的花括号必须由空格或换行符分隔;
- 同样, 当使用花括号时, 那个 *列表* 必须以一个分号, 一个 '&' 或者一个换行符终结;
- *#* 被扩展成位置参数的个数;
- *DEBUG* 和 *RETURN* 陷井不会被继承, 除非函数被给予了 *trace* 特性;
  (在这种情况下, 所有的函数将会继承 DEBUG 和 RETURN 陷阱)

  此特性使用 *declare* 内建或 *set* 内建的 *-o functrace* 的选项启用;
  
  *ERR* 陷阱不会被继承, 除非开启了*-o errtrace* 选项;
- 变量 *FUNCNEST* , 如果设置为大于 0 的数字值, 定义函数最大嵌套等级;

  超出嵌套限制的函数调用将导致全部命令被放弃执行;
- 函数可以是递归的; 
  *FUNCNEST* 变量可用于限制函数调用堆栈的深度, 并限制函数调用的数目;
  默认情况下, 不限制递归调用的数量;

- 如果内置命令 *return* 在函数中被执行, 在函数调用后此函数结束,

  然后执行下一个命令;
- 在执行恢复之前, 将执行与 *RETURN* 陷阱关联的任何命令;
- 当函数完成时, 位置参数和特殊参数 "#" 的值将恢复到函数执行之前的值;
- 如果给 return 一个数字参数, 此数字就是返回状态;

  否则, 函数的返回状态就是 return 前的命令的返回状态;

- 函数的局部变量可被用内置的 local 来声明;

  此变量仅函数内部可见;

- 函数名和定义可用内置的 *declare(typeset)* 命令的 *-f* 选项列出
- *declare* 和 *typeset* 的 *-F* 选项将仅列出函数名;
  (如果开启了 *extdebug* , 可选地列出源文件和行号 [#declare]_ )
- 函数可被内置的 *export* 命令的 *-f* 选项导出, 以便子 shell 自动地持有它们;
- 具有相同名称的 shell 函数和变量可能会在传递给 shell 子级的环境中生成多个同名项;

3.4 shell 参数
++++++++++++++++++++++++++++++++++++++++++++++++++

- shell 参数可以是: 名称 , 数字和特殊符号
- 变量是由名称表示的参数;

  变量有一个值并且有 0 个或多个属性;

  使用内置命令 *declare* 为变量分配属性;
- 空字符串是合法的值;
- 变量设定完, 可通过内置命令 *unset* 取消设定
- 变量设定形式: ``name=[value]``

  - 如果没有 *value* , 变量的值就是空字符串;
  - 所有值都经过大括号扩展、参数和变量扩展、命令替换、算术扩展和引号删除;
  - 如果变量具有其 *integer* 属性集, 则即使不使用 $ ((...) 扩展, 也将值计算为算术表达式;
  - 除 "$ @ " 外, 不执行单词拆分;
  - 不执行文件名扩展;
  - 赋值语句也可显示为内建命令 *alias*, *declare*, *typeset*, *export*, *readonly* 和 *local* 的参数;
  - 在赋值语句为 shell 变量或数组索引 (请参见数组) 分配数值的上下文中,
    "+=" 运算符可用于追加到变量的上一个值, 也可以添加到它;

    - 用于设置了整型属性的变量时 ::

	[root@work test]# declare -i test=1
	[root@work test]# echo $test
	1
	[root@work test]# test+=1
	[root@work test]# echo $test
	2
	如果不声明为整型变量时, 结果将会是 11
	

    - 应用于使用复合赋值的数组变量 [#array_variable]_ 时

      - 声明为索引数组变量时

        - 声明为普通索引数组变量时:

	  会变成追加;

	  ::

	    [root@work test]# declare -a array=(2 4 6 8)
	    [root@work test]# for i in ${array[@]}; do echo $i;done
	    2 4 6 8
	    [root@work test]# array+=10
	    [root@work test]# for i in ${array[@]}; do echo $i;done
	    210 4 6 8
	    [root@work test]# array[2]+=10
	    [root@work test]# for i in ${array[@]}; do echo $i;done
	    210 4 610 8

        - 声明为整型索引数组变量时 ``declare -ai array1=(2 4 6 8)``
	  ``declare -ai array2=(a b c d)``

	  - 在 array1 中, 除使用 **array1+=22** , 会直接替换 array[0] 的值为 22 以外,
	    其余诸如 **array1[i]+=2** , 会在原有的数字基础上增加;
	  - 在 array2 中, 任何的 **array1[i]+=2** 都会直接替换原有的值;

	    形如 **array1[i]+=a**, 如果 i 值超出索引, 则在尾部增加一个索引值为 i 的索引, 使其值为 0;
	    如果索引位置上的值是字符, 则将索引位的值设为 0; 如果是数字, 则不变;

	  
      - 声明为关联数组变量时

	- 声明为普通关联数组变量时 ``declare -A test``

	  ::

	     test+=2 # 将得到索引为 0, 值为 2 的数组;
	     test+=4 # 索引不变, 值变成了 24 ; 就相当于字符拼接;
	             # 也就是说, test+=4, 相当于 test[0]+=4

	- 声明为整型关联数组变量时 ``declare -Ai test``

	  ::

	     test+=a # 将得到索引为 0, 值为 a 的数组;
	     test+=3 # 上一表达式值相当于 0, 所以此次得到索引为 0, 值为 3 的数组;

    总的来说: 如果被声明为 Integer, 那么值只能是数字, 即使在初始化时可以被赋值为非数字,
    但只要对其进行操作时, 非数字的部分都会变成 0 以便运算; 如果没有被声明为 Integer,
    那么在进行 += 操作时, 只能变成字符的拼接;


- 使用 *declare* 或者 *local* 的 *-n* 选项给变量赋予 **nameref** 特性以创建一个 **nameref**
  或者一个指向其它变量的引用; 这样便可间接的操作变量;
- 无论何时, 引用, 赋值, 销毁 nameref 变量或者修改其属性,
  实际操作的都是在由 nameref 变量的值指向的变量上执行 [#nameref]_;
- nameref 通常用于 shell 函数中, 以引用其名称作为参数传递给函数的变量;

  例如, 如果变量名作为第一个参数传递给 shell 函数, 在函数中运行
  ``declare -n ref=$1`` [#declare_ref]_ 将创建一个 nameref 变量 ref,
  它的值是作为第一个参数传递的变量名;

- 对 ref 的引用和赋值以及对其属性的更改将被视为对作为 $1 传递的变量的引用, 赋值和属性修改;


- 如果 for 循环里的控制变量有 nameref 属性, 单词的列表可以是 shell 变量的列表,
  而且当循环被执行时, 一个名称引用被依次建立给每一个在列表中的单词;
- 数组变量不能给予 nameref 属性; 但, nameref 变量可以引用数组变量和下标数组变量;
- nameref 变量可被 unset 使用 -n 选项销毁;
- 如果 unset 以 nameref 变量名作为参数执行, nameref 变量引用的变量也将被销毁;
  


3.4.1 位置参数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- 位置参数是由一个或多个数字表示的参数, 而不是单个数字 0;
- 位置参数在调用时从 shell 的参数中分配, 并且可以使用 set 内置命令重新分配;
- 位置参数 *n* 可以被引用为 *${n}*, 或者当 *n* 由一个数字组成时 *$n*;
- 不能将位置参数分配给赋值语句;
- 内置命令 *set* 和 *shift* 用来设定和取消设定位置参数;
- 当执行 shell 函数时, 位置参数被临时替换;
- 当一个包含多个数字的位置参数展开时, 它必须用大括号括起来;

3.4.2 特殊参数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- **\***

  - ``$*`` 扩展为位置参数;
  - 当扩展不在双引号内时, 每个位置参数扩展到一个单独的词 [#positional_parameter]_;
  - 在执行该操作的上下文中, 这些单词将受到进一步的单词拆分和路径名扩展;
  - 当扩展在双引号内发生时, 它扩展为一个单词,
    每个参数的值由 *IFS* 特殊变量的第一个字符分隔;

    即 ``"$*"`` 等同于 ``$1c$2c...`` , 其中 *c* 是 IFS 变量值的第一个字符;

    如果 **IFS** 未设定, 参数被空格分割;

    如果 **IFS** 为空, 则在不带分隔符的情况下将参数拼接在一起;

- **@**

  - ``$@`` 扩展为位置参数;
  - 当扩展在双引号内发生时, 每个参数扩展到一个单独的单词;
  - 也就是说, "$@" 等同于 "$1" "$2" ...;
  - 如果双引号的扩展发生在一个单词内,
    则第一个参数的扩展将与原始单词的起始部分联接,
    最后一个参数的扩展与原始单词的最后一部分连接起来;
    如果没有位置参数, 扩展为空 ::

      #!/bin/bash
      # Filename: test

      echo hehe$@hehe
      echo haha"$@"haha

      > ./test 1 2 3
       hehe1 2 3hehe
       haha1 2 3haha

      > ./test
       hehehehe
       hahahaha

- **#**

  - ``$#`` 展开成位置参数的个数;

- **?**

  - ``$?`` 扩展到最近执行的前台管道的退出状态;

- **-**

  - ``$-`` 按调用时指定的当前选项标志展开, 由 set 内置命令或由 shell 本身设置的;

    - 对于 bash 来说, 一般是 ``himBH``
    - 对于 zsh  来说, 一般是 ``569JNRXZghiklms``, 如果你用的最新的 oh-my-zsh 配置文件

- **$**

  - ``$$`` 展开成 shell 的进程ID;
  - 在一个 ``()`` 子shell, 展开成调用 shell 的 PID, 而不是子 shell;

- **!**

  - ``$!`` 扩展到最近放置到后台的作业的进程 ID, 无论是作为异步命令执行还是使用 bg 内置;

- **0**

  - ``$0`` 扩展为 shell 的名字或者 shell 脚本的名字;

- **_**

  - ``$_`` 在 shell 启动时, 设置为用于调用在环境或参数列表中传递的 shell 或
    shell 脚本的绝对路径名;
  - 接着, 扩展成上一条命令的最后一个参数; ::

      > echo 1 2 3
        1 2 3
      > echo $_
        3

  - 还能设置为用于调用执行并放置在导出到该命令的环境中的每个命令的完整路径名 [#underscore]_;
  - 检查邮件时, 此参数保存邮件文件的名称;



历史记录大小
------------------------------------------------------------

``-o history`` 打开;

#. shell 变量
   **HISTSIZE** 历史记录大小, 默认500;

   **HISTIGNORE and HISTCONTROL**

   **HISTFILE** 默认值是 ~/.bash_history, bash 启动时读取此变量指定的文件
   中的记录作为历史记录;
   
   **HISTFILESIZE**
   
   **HISTTIMEFORMAT** :doc:`history记录操作时间<../history>`

#. shell 选项
   histappend
   
   cmdhist
   
   lithist

#. 内置命令

  fc [#fc]_ [-e ename] [-lnr] [first] [last]

  fc -s [pat=rep] [command]

fc -l 仅列出最近的 16 条命令;

fc -l 100 仅列出 第100条到最近一条的命令;

fc -l 10 100 列出指定范围的命令;

fc -l -n 列出命令时, 不显示命令的序号;

fc -l -r 反向列出命令;

fc -e emacs 以 emacs 打开并显示最近一条命令;

   

#. 变量 ``FCEDIT`` 指定了显示或修改命令的编辑器

.. rubric:: 注

.. [#fc] Fix Command;
.. [#nocasematch] 通过 shopt 开关;
.. [#hist_reason] 这是因为大括号是保留字, 只有当它们与命令列表中的空格或其他 shell
		  元字符分开时才会被识别;
.. [#declare] 实际测试发现, ``declare -F`` 将会输出成 **declare -f fun_name**
.. [#positional_parameter] 结果集可被遍历, 反之, 在双引号的无法被遍历;
.. [#underscore] 这句完全不能理解;
.. [#array_variable] 对于数组变量, 数组名就是存的就是第一个索引;
.. [#nameref] 除了使用或更改 nameref 属性本身
.. [#declare_ref] 实际上, 直接使用 declare -n ref=$1 会报非法选项,
		  但是在函数内使用 local, 则没有问题;
