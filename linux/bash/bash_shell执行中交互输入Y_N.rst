==========================
 Shell 执行中交互输入 Y/N
==========================

.. code-block:: bash

   #!/bin/bash

   function confirm() {
       question=$1
       read -n1 -p ${question}'[Y/N]?' answer
       case ${answer} in
       Y | y) echo
           echo "Continue ...";;
       N | n) echo
           echo "Good Bye !!!"
           exit;;
       esac
   }

   confirm '是否继续'

   echo 'Welcome !!!'
