#!/bin/sh
set -e


cd `dirname $0`
INDEX_HTML=./_book/index.html

git checkout master &&\
gitbook init &&\
gitbook build &&\
#去除目录里边的“Published with GitBook”项
sed -i "" s/^.*www.gitbook.com.*$/" "/g ${INDEX_HTML}
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
