USE [master]
GO
ALTER DATABASE NewClassesAdmin SET RECOVERY SIMPLE WITH NO_WAIT
GO

ALTER DATABASE NewClassesAdmin SET RECOVERY SIMPLE --��ģʽ
GO

USE [NewClassesAdmin]
GO

DBCC SHRINKFILE (N'NewClassesAdmin_log',1024, TRUNCATEONLY) --������1024M
GO

USE [master]
GO

ALTER DATABASE NewClassesAdmin SET RECOVERY FULL WITH NO_WAIT
GO

ALTER DATABASE NewClassesAdmin SET RECOVERY FULL --��ԭΪ��ȫģʽ
GO

--��֪����־���֣���ѯ������
USE  [NewClassesAdmin]
GO
SELECT file_id, name FROM sys.database_files;
GO


--�Զ�����
EXEC sp_dboption 'NewClassesAdmin', 'autoshrink', 'false'


--��ñ�����־���Ժ��ͨ����־�ָ����ݡ�����
����Ϊ��־������
һ�㲻��������4,6����
��4������ȫ,�п��������ݿ��ʧ����
��6�������־�ﵽ����,���Ժ�����ݿ⴦���ʧ��,��������־����ָܻ�.
--*/

--��������п�����ָ��Ҫ��������ݿ�Ŀ���

1.�����־
DUMP TRANSACTION ���� WITH NO_LOG

2.�ض�������־��
BACKUP LOG ���� WITH NO_LOG

3.�������ݿ��ļ�(�����ѹ��,���ݿ���ļ������С
��ҵ������--�Ҽ���Ҫѹ�������ݿ�--��������--�������ݿ�--�����ļ�
--ѡ����־�ļ�--��������ʽ��ѡ��������XXM,��������һ����������������СM��,ֱ�����������,ȷ���Ϳ�����
--ѡ�������ļ�--��������ʽ��ѡ��������XXM,��������һ����������������СM��,ֱ�����������,ȷ���Ϳ�����

Ҳ������SQL�������� 
--�������ݿ�
DBCC SHRINKDATABASE(����)

--����ָ�������ļ�,1���ļ���,����ͨ���������ѯ��:select * from sysfiles
DBCC SHRINKFILE(1)

4.Ϊ����󻯵���С��־�ļ�(�����sql 7.0,�ⲽֻ���ڲ�ѯ�������н���)
a.�������ݿ�:
��ҵ������--������--���ݿ�--�Ҽ�--�������ݿ�

b.���ҵĵ�����ɾ��LOG�ļ�

c.�������ݿ�:
��ҵ������--������--���ݿ�--�Ҽ�--�������ݿ�

�˷��������µ�LOG����Сֻ��500��K

���ô��룺 
�����ʾ������ pubs��Ȼ�� pubs �е�һ���ļ����ӵ���ǰ��������

a.����
EXEC sp_detach_db @dbname = '����'

b.ɾ����־�ļ�

c.�ٸ���
EXEC sp_attach_single_file_db @dbname = '����', 
@physname = 'c:\Program Files\Microsoft SQL Server\MSSQL\Data\����.mdf'

5.Ϊ���Ժ����Զ�����,����������:
��ҵ������--������--�Ҽ����ݿ�--����--ѡ��--ѡ��"�Զ�����"

--SQL������÷�ʽ:
EXEC sp_dboption '����', 'autoshrink', 'TRUE'

6.������Ժ�������־������̫��
��ҵ������--������--�Ҽ����ݿ�--����--������־
--���ļ���������ΪxM(x�����������������ļ���С)

--SQL�������÷�ʽ:
alter database ���� modify file(name=�߼��ļ���,maxsize=20)













