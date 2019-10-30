### DBColumn注解能力级

```java
    void init(S db);
    void create();
    long insert(T model);
    long insertOrUpdate(T model);
    /**
     * 批量插入事务
     * @param models
     */
    void insertOrUpdates(List<T> models);
    List<T> queryAll();
    int delete(String whereClauses, String[] whereArgs);
    /**
     * 以主键为删除依据
     * @param whereArgs
     * @return
     */
    int deleteByPrimary(String whereArgs);
    /**
     * 默认数据库升级操作，仅支持表新增列，新增表
     */
    void updateTableColumn();
```



### 接入：

1、导入`cydb-library.jar`包

2、为需要生成数据表的model添加注释

```java
public @interface DBColumn {
    /**
     * 设置列别名
     * @return
     */
    String name() default "";
    /**
     * 是否为主键
     * @return
     */
    boolean primary() default false;
}

```

样例：

```java
public class User extends BaseModel{
    @DBColumn(primary = true)
    private int id;
    @DBColumn
    String name;
    @DBColumn
    private String num;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getNum() {
        return num;
    }
    public void setNum(String num) {
        this.num = num;
    }
}
```

3、初始化数据库相关

```java
//设置库名、版本号，加密密钥
DBHelper.setConfig(String dbName, int dbVersion, String dbPwd)；
//初始化
DBHelper.init(Context context, DBModelsConstant.models);
```



4、使用相关

```java
//批量插入
DBHelper.getInstance().getDBProtocol(User.class).insertOrUpdates(list);
//查询
List<User> list =  DBHelper.getInstance().getDBProtocol(User.class).queryAll();
```

