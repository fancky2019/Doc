
-- 1．ALTER TABLE ALTER TABLE用来创建普通索引、UNIQUE索引或PRIMARY KEY索引。

 
ALTER TABLE table_name ADD INDEX index_name (column_list)
-- 可以多列
ALTER TABLE table_name ADD UNIQUE (column_list)

-- 唯一的主键索引 
ALTER TABLE table_name ADD PRIMARY KEY (column_list)

-- 其中table_name是要增加索引的表名，column_list指出对哪些列进行索引，多列时各列之间用逗号分隔。
-- 索引名index_name可选，缺省时，MySQL将根据第一个索引列赋一个名称。另外，ALTER TABLE允许在单个语句中更改多个表，因此可以在同时创建多个索引。

-- 一个表只能包含一个PRIMARY KEY，因为一个表中不可能具有两个同名的索引。

-- 2．CREATE INDEX CREATE INDEX可对表增加普通索引或UNIQUE索引。

CREATE INDEX index_name ON table_name (column_list)

CREATE UNIQUE INDEX index_name ON table_name (column_list)


--  3、删除索引
 
DROP INDEX index_name ON talbe_name

ALTER TABLE table_name DROP INDEX index_name

ALTER TABLE table_name DROP PRIMARY KEY

-- 4、查看索引
show index from t_crm_clue;

show index from t_crm_clue_tag_transfer_record