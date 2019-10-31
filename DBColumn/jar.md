# jar包生成

[cydb-library](http://github.com/altair861/DBColumn.git)的项目结构为

![image-20191030164442300](../pic/image-library.png)

分别将db-annotation,db-processor,db-library生成对应jar包，然后加上javapoet-1.11.1.jar包，将4个jar包合为一个即可，

`buildProcessor.sh`中有相应实现，主要为

```shell
function build_jar() {
    cd ${SDK_ROOT}
    echo ${SDK_ROOT}
    mkdir -p "tmp/"

    gradle db-processor:jar
    copy db-processor/build/libs/db-processor.jar tmp/
    copy db-processor/libs/javapoet-1.11.1.jar tmp/

    gradle db-annotation:jar
    copy db-annotation/build/libs/db-annotation.jar tmp/

    gradle db-library:build
    copy db-library/build/intermediates/intermediate-jars/debug/classes.jar tmp/db-library.jar

    copy build.xml tmp/
    cd tmp
    ant -buildfile build.xml

    cd -
    mkdir -p "db-library/build/outputs/libs/"
    copy tmp/cydb-library.jar db-library/build/outputs/libs/

    rm -rf tmp
}
```

执行`buildProcessor.sh`即可得到cydb-library.jar