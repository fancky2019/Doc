alter table NewClassesAdmin.dbo.VaildType add OrderNum tinyint  null default 0






-- 修改字段类型长度
ALTER TABLE userinfo
ALTER COLUMN name varchar(100);

-- 修改字段类型
ALTER TABLE userinfo ALTER COLUMN age float;

-- 修改字段不允许 NULL 值
ALTER TABLE userinfo ALTER COLUMN age float NOT NULL;

-- 添加主键
ALTER TABLE userinfo ADD CONSTRAINT id_name PRIMARY KEY(ID);

-- 修改字段名 (执行后会有提示：注意: 更改对象名的任一部分都可能会破坏脚本和存储过程。)
EXEC sp_rename "userinfo.age","userage","COLUMN";

-- 添加字段名
ALTER TABLE userinfo ADD gender bit DEFAULT 0;

-- 删除表
DROP TABLE userinfo;








