alter table NewClassesAdmin.dbo.VaildType add OrderNum tinyint  null default 0






-- �޸��ֶ����ͳ���
ALTER TABLE userinfo
ALTER COLUMN name varchar(100);

-- �޸��ֶ�����
ALTER TABLE userinfo ALTER COLUMN age float;

-- �޸��ֶβ����� NULL ֵ
ALTER TABLE userinfo ALTER COLUMN age float NOT NULL;

-- �������
ALTER TABLE userinfo ADD CONSTRAINT id_name PRIMARY KEY(ID);

-- �޸��ֶ��� (ִ�к������ʾ��ע��: ���Ķ���������һ���ֶ����ܻ��ƻ��ű��ʹ洢���̡�)
EXEC sp_rename "userinfo.age","userage","COLUMN";

-- ����ֶ���
ALTER TABLE userinfo ADD gender bit DEFAULT 0;

-- ɾ����
DROP TABLE userinfo;








