1.�޸ı���
��ʽ��sp_rename tablename,newtablename

sp_rename tablename,newtablename
2.�޸��ֶ���
��ʽ��sp_rename ��tablename.colname��,newcolname,��column��

sp_rename ��tablename.colname��,newcolname,��column��
3.����ֶ�
��ʽ��alter table table_name add new_column data_type [interality_codition]
ʾ��1

ALTER TABLE student Add nationality varchar(20)
--ʾ��2 ���int���͵���,Ĭ��ֵΪ 0 

alter table student add studentName int default 0 --ʾ��3 ���int���͵���,Ĭ��ֵΪ0������ 
alter table student add studentId int primary key default 0 --ʾ��4 �ж�student���Ƿ����name�ֶ���ɾ���ֶ� 
if exists(select * from syscolumns where id=object_id(��student��) and name=��name��) begin
alter table student DROP COLUMN name
end
4.�����ֶ�
��ʽ��alter table table_name alter column column_name

ALTER TABLE student ALTER COLUMN name VARCHAR(200)
5.ɾ���ֶ�
��ʽ��alter table table_name drop column column_name

ALTER TABLE student DROP COLUMN nationality;
6.�鿴�ֶ�Լ��
��ʽ�� select * from information_schema.constraint_column_usage where TABLE_NAME = table_name

SELECT TABLE_NAME,COLUMN_NAME,CONSTRAINT_NAME FROM information_schema.CONSTRAINT_COLUMN_USAGE
WHERE TABLE_NAME = ��student��
7.�鿴�ֶ�ȱʡԼ�����ʽ ����Ĭ��ֵ�ȣ�
��ʽ��select * from information_schema.columns where TABLE_NAME = table_name

SELECT TABLE_NAME, COLUMN_NAME, COLUMN_DEFAULT FROM information_schema.COLUMNS
WHERE TABLE_NAME=��student��
8.�鿴�ֶ�ȱʡԼ����
��ʽ��select name from sysobjects where object_id(table_name)=parent_obj and xtype=��D��

select name from sysobjects
where object_id(����?��?��)=parent_obj and xtype=��D��
9.ɾ���ֶ�Լ��
��ʽ��alter table tablename drop constraint constraintname

ALTER TABLE student DROP CONSTRAINT PK__student__2F36BC5B772B9A0B
10.����ֶ�Լ��
��ʽ��alter table tablename add constraint constraintname primary key (column_name)
--ʾ��1 
ALTER TABLE stuInfo ADD CONSTRAINT PK_stuNo PRIMARY KEY (stuNo) --ʾ��2 �������Լ����Primary Key��