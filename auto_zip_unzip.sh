#解压zip包脚本如下：
#!/bin/sh 

PATH1=/tmp/images 
PATH2=/usr/www/images
 
#Print welcome info  
cat <<EOF 
++--------------------------------------------------------++ 

++-----------welcome to use auto  tar scripts-------------++ 

++--------------------------------------------------------++ 
EOF

#find Dir all TAR packages 查找/tmp/images目录下所有的tar包
for i in `find  $PATH1  -name  "*.tar" ` 
do 
    tar -xvf  $i  -C $PATH2 
done 

#解压TAR包脚本如下：
#!/bin/sh 
PATH1=/tmp/images 
PATH2=/usr/www/images 

#Find Dir all ZIP packages 查找/tmp/images目录下所有的tar包，并创建解压目录

cd $PATH1 
for i in `find  . -name  "*.zip"|awk  -F.  {print $2} ` 
do 
    mkdir -p   PATH2$i 
    unzip -o  .$i.zip  -d   PATH2$i 
done
