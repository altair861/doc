#!/bin/sh
set -e

cd `dirname $0`
INDEX_HTML=./_book/index.html

function getLine() {
    str=$1
    path=$2
    grep -n ${str} ${path} | cut -d ":" -f 1
}

function delGitBookItem() {
	filePath=$1
    count=$(getLine "www.gitbook.com" $filePath)
	echo "find in:${count},$filePath"
	sed -i "" "`expr $count - 1`,`expr $count + 3`d" $filePath
}

function BatchDelGitBookItem(){
	#在_book路径下查找html文件
	filelist=$(find _book -name "*.html")
    for cfilename in $filelist
     do
        delGitBookItem $cfilename
     done
}


git checkout master &&\
#:<<!
gitbook init &&\
gitbook build &&\
#去除目录里边的“Published with GitBook”项
BatchDelGitBookItem
#变更index.html中图片的相对路径
#sed -i "" s/"\.\.\/pic"/"\.\/pic"/g $INDEX_HTML
git add . &&\
git commit -m 'update gitbook' &&\
git push origin master &&\
git checkout gh-pages &&\
rm -rf * &&\
git checkout master -- _book &&\
mv _book/* ./ &&\
rm -rf _book &&\
rm -rf publish.sh &&\
git add . &&\
git commit -m 'publish gh-pages' &&\
git push origin gh-pages &&\
git checkout master
#!

