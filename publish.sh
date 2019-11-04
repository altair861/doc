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
    count=$(getLine "www.gitbook.com" $INDEX_HTML)
	echo "find in:${count}"
	sed -i "" "`expr $count - 1`,`expr $count + 3`d" $INDEX_HTML
}



git checkout master &&\
gitbook init &&\
gitbook build &&\
#去除目录里边的“Published with GitBook”项
delGitBookItem
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

