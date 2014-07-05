#!/bin/sh 

###nginx install shell 

###Define PATH  定义变量
SOFT_PATH=/data/soft/ 
NGINX_FILE=nginx-1.2.4.tar.gz 
DOWN_PATH=http://nginx.org/download/ 

#Define DIR and mkdir soft DIR  创建软件目录
if 
    [ ! -d $SOFT_PATH ];then 
    mkdir -p $SOFT_PATH 
fi 


#Define download function  定义download函数
download () 
{ 
    cd $SOFT_PATH ;wget $DOWN_PATH/$NGINX_FILE 
} 

#Define install function   定义install函数
install () 
{ 
    yum install pcre-devel -y 
    cd $SOFT_PATH ;tar xzf $NGINX_FILE  
    cd nginx-1.2.4/ &&./configure --prefix=/usr/local/nginx/ --with-http_stub_status_module --with-http_ssl_module 
    [ $? -eq 0 ]&&make &&make install 
} 
#Start Nginx Server Define start function 定义start函数
start () 
{ 
    lsof -i :80 
   [ $? -ne 0 ]&&/usr/local/nginx/sbin/nginx 
} 

#Stop Nginx Server Define stop function   定义stop函数
stop () 
{ 
 ps -ef |grep nginx |grep -v grep |awk '{print $2}'|xargs kill -9 
} 

#Config Case menu install  配置case 安装菜单
case  $1  in 
    download ) 
    download 
;; 
    install ) 
    install 
;; 
    start ) 
    start 
;; 
    stop ) 
    stop 
;; 
      * ) 
    echo "USAGE:$0 {download or install or start or stop}" 
    exit $? 
esac 
