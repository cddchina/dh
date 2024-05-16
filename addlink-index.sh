#!/bin/bash

echo "===> in param num is :"$#

if [[ $# -lt 3 ]];then
	echo "===> in param num is too low, usage: sh xxx.sh uniquekey link  showname"
	exit -1
fi

echo "==================================>"
echo "===> uniquekey:" $1
echo "===> link:" $2
echo "===> showname:" $3
echo "==================================>"

# 判断要插入的链接是否已经存在
link_exist=`grep -n $2 index.html  | head -1 | cut -d ":" -f 1`
if [  ! -z $link_exist ];then
	echo "===> search link exist, can't add"
	exit -1
fi

# 判断要插入的别名是否已经存在
show_name=`grep -n $3 index.html  | head -1 | cut -d ":" -f 1`
if [  ! -z $show_name ];then
	echo "===> search show_name exist, can't add"
	exit -1
fi

addnum=`grep -n $1 index.html  | head -1 | cut -d ":" -f 1`

if [ -z $addnum ];then
	echo "===> search uniquekey none, please replace try again."
	exit -1
fi
echo "===> search uniquekey line num is :"$addnum

#要替换的自定义格式
macrostr="<li><a onmousedown=\"return c(183)\" href=\"URL_CDDCHINA\" target=\"_blank\">NAME_CDDCHINA</a></li>"

echo $macrostr

addnum=$(($addnum+1)) 

sed -i "${addnum}i \ \ \ \ \t\t\t\t\t${macrostr}" index.html

sed -i 's%URL_CDDCHINA%'"$2"'%' index.html

sed -i 's%NAME_CDDCHINA%'"$3"'%' index.html

echo "===> replace end, result is:"
sed -n "${addnum}p" index.html