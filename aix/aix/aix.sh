#!/usr/bin/ksh
##################################################
#@desc: 每隔1秒显示AIX的剩余内存
#@author:lpm
#@date:2014-7-5
#@usag: 
##################################################
 
while [ 1 -eq 1 ]
do
    x=`svmon -G | grep memory | awk '{print $4}'`
    y=`expr $x \* 4 \/ 1024`
    echo '剩余'$y'M'
    echo `date +%T'
    sleep 1
done
