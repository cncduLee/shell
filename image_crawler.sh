#!/bin/bash

##################################################
#@desc: 获取网络图片(curl)
#@author:lpm
#@date:2014-7-5
#@usag: ./image_crawler.sh www.baidu.com -d ./img
##################################################

#validate
if [[ $# -ne 3 ]]
then
 echo "Usage: $0 URL -d DIRECTORY"
 exit -1;
fi

#取出参数，赋值
for i in {1..4}
do
 case $1 in
  #dir	
  -d) 
  shift
  directory=$1
  shift;;
  #url
  *) 
  url=${url:-$1}
  shift;;
 esac
done	

echo "***********************"
echo "input dir:$directory"
echo "input url:$url"

mkdir -p $directory
baseurl=$(echo $url | egrep -o "https?://[a-z.]+")

echo "base url:$baseurl"
echo "***********************"


#获取当页的所有图片链接，保存到临时文件$$.list中
curl -s $url | egrep -o "<img src=[^>]*>" | sed 's/<img src=\"\([^"]*\).*/\1/g' > /tmp/$$.list
sed -i "s|^/|$baseurl/|" /tmp/$$.list

#进入dir存放文件的目录
cd $directory;

#down load
while read filename
do
 echo "get image from link:$filename"
 curl -s -O "$filename" --silent
done < /tmp/$$.list

#done
echo "done!"
exit 0
