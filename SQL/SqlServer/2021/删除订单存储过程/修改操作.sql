1.修改表名
格式：sp_rename tablename,newtablename

sp_rename tablename,newtablename
2.修改字段名
格式：sp_rename ‘tablename.colname‘,newcolname,‘column‘

sp_rename ‘tablename.colname‘,newcolname,‘column‘
3.添加字段
格式：alter table table_name add new_column data_type [interality_codition]
示例1

ALTER TABLE student Add nationality varchar(20)
--示例2 添加int类型的列,默认值为 0 

alter table student add studentName int default 0 --示例3 添加int类型的列,默认值为0，主键 
alter table student add studentId int primary key default 0 --示例4 判断student中是否存在name字段且删除字段 
if exists(select * from syscolumns where id=object_id(‘student‘) and name=‘name‘) begin
alter table student DROP COLUMN name
end
4.更改字段
格式：alter table table_name alter column column_name

ALTER TABLE student ALTER COLUMN name VARCHAR(200)
5.删除字段
格式：alter table table_name drop column column_name

ALTER TABLE student DROP COLUMN nationality;
6.查看字段约束
格式： select * from information_schema.constraint_column_usage where TABLE_NAME = table_name

SELECT TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME FROM information_schema.CONSTRAINT_COLUMN_USAGE
WHERE TABLE_NAME = ‘student‘
7.查看字段缺省约束表达式 （即默认值等）
格式：select * from information_schema.columns where TABLE_NAME = table_name

SELECT TABLE_NAME, COLUMN_NAME, COLUMN_DEFAULT FROM information_schema.COLUMNS
WHERE TABLE_NAME=‘student‘
8.查看字段缺省约束名
格式：select name from sysobjects where object_id(table_name)=parent_obj and xtype=‘D‘

select name from sysobjects
where object_id(‘表?名?‘)=parent_obj and xtype=‘D‘
9.删除字段约束
格式：alter table tablename drop constraint constraintname

ALTER TABLE student DROP CONSTRAINT PK__student__2F36BC5B772B9A0B
10.添加字段约束
格式：alter table tablename add constraint constraintname primary key (column_name)
--示例1 
ALTER TABLE stuInfo ADD CONSTRAINT PK_stuNo PRIMARY KEY (stuNo) --示例2 添加主键约束（Primary Key）