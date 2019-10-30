# 目录

* [realm从入门到放弃](README.md)   
* [第一章](Chapter1/README.md)
  * [第1节：衣](Chapter1/衣.md)
  * [第2节：食](Chapter1/食.md)
  * [第3节：住](Chapter1/住.md)
  * [第4节：行](Chapter1/行.md)
* [第二章](Chapter2/README.md)
* [第三章](Chapter3/README.md)
* [第四章](Chapter4/README.md)


###### **Aaaa1**

1、继承基类问题

```@RealmClass```

```public class User extends BaseModel implements RealmModel```

很正常的一个需求，结果：

`错误: Realm model classes must either extend RealmObject or implement RealmModel to be considered a valid model class`

2、表更新

>/**

  \* 升级数据库

  */

 class CustomMigration implements RealmMigration {

​     @Override

​     public void migrate(DynamicRealm realm, long oldVersion, long newVersion) {

​         RealmSchema schema = realm.getSchema();

​         if (oldVersion == 0 && newVersion == 1) {

​             RealmObjectSchema personSchema = schema.get("User");

​             //新增@Required的id

​             personSchema

​                     .addField("id", String.class, FieldAttribute.REQUIRED)

​                     .transform(new RealmObjectSchema.Function() {

​                         @Override

​                         public void apply(DynamicReal

mObject obj) {

​                             obj.set("id", "1");//为id设置值

​                         }

​                     })

​                     .removeField("age");//移除age属性

​             oldVersion++;

​         }

​     }

}

3、查询结果，intent传值问题 

![image-intent](./pic/image-intent.png)

4、其他：线程；realmlist没有序列化；Realmlist<T>中，T必须继承RealmObject，ealmList<String>;自己维护primarykey

