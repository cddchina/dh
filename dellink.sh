#!/bin/bash

echo "===> in param num is :"$#

if [[ $# -lt 2 ]];then
	echo "===> in param num is too low, usage: sh uniquekey filename"
	exit -1
fi

echo "==================================>"
echo "===> uniquekey:" $1
echo "===> filename:" $2
echo "==================================>"

# 判断要插入的链接是否已经存在
link_exist=`grep -n $1 $2  | head -1 | cut -d ":" -f 1`
if [  -z $link_exist ];then
	echo "===> search link exist, can't delete"
	exit -1
fi


delnum=`grep -n $1 $2  | head -1 | cut -d ":" -f 1`

if [ -z $delnum ];then
	echo "===> search uniquekey none, please replace try again."
	exit -1
fi
echo "===> search uniquekey line num is :"$delnum
echo "===> will delete context is:"
sed -n "${delnum}p" $2

while true
do
    read -r -p "Are You Sure? [Y/n] " input
 
    case $input in
        [yY][eE][sS]|[yY])
            echo "Yes"
            break
            ;;
 
        [nN][oO]|[nN])
            echo "No"
            exit 1               
            ;;
 
        *)
            echo "Invalid input..."
            ;;
    esac
done
 
sed -i "${delnum}d" $2

echo "===> delete end."
