--ѭ��
declare @n int =1
while @n<=12
begin
print(@n)
set @n=@n+1  --set ��ֵ
end

declare @m int =1
while @m<=12
begin
print(@m)
select @m=@m+1  --select��ֵ
end

use [CustomerRelationship_AH];
with SellerSubject_CTE AS(
SELECT * FROM [CustomerRelationship_AH].[dbo].[SellerSubject]
 )

 select * into #SellerSubject from  SellerSubject_CTE
 drop table  #SellerSubject
go
--�ж���ʱ���Ƿ����
use [CustomerRelationship_AH];
go
if exists(select * from tempdb..sysobjects where id=object_id('tempdb..#SellerSubject'))
PRINT '����' 
ELSE 
PRINT'������'

--�ж���ʱ���Ƿ����
use [CustomerRelationship_AH];
go
if exists (select * from tempdb.dbo.sysobjects where id = object_id(N'tempdb..#SellerSubject') and type='U')
PRINT '����' 
ELSE 
PRINT'������'

--�жϱ��Ƿ����
USE [CustomerRelationship_AH];
GO
IF EXISTS  (SELECT  * FROM dbo.SysObjects WHERE ID = object_id(N'[SellerSubject]') AND OBJECTPROPERTY(ID, 'IsTable') = 1) 
PRINT '����' 
ELSE 
PRINT'������'

--1 �ж����ݿ��Ƿ����
if exists (select * from sys.databases where name = '���ݿ���')  
  drop database [���ݿ���] 

--2 �жϱ��Ƿ����
if exists (select * from sysobjects where id = object_id(N'[����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)  
  drop table [����] 

--3 �жϴ洢�����Ƿ����
if exists (select * from sysobjects where id = object_id(N'[�洢������]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)  
  drop procedure [�洢������]


--4 �ж���ʱ���Ƿ����
if object_id('tempdb..#��ʱ����') is not null    
  drop table #��ʱ����

--5 �ж���ͼ�Ƿ���� 

--�ж��Ƿ����'MyView52'�����ͼ
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'MyView52')
PRINT '����'
else
PRINT '������'
--6 �жϺ����Ƿ���� 
--  �ж�Ҫ�����ĺ������Ƿ����    
  if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������]') and xtype in (N'FN', N'IF', N'TF'))    
  drop function [dbo].[������] 

--7 ��ȡ�û������Ķ�����Ϣ

SELECT [name],[id],crdate FROM sysobjects where xtype='U' 


   

--8 �ж����Ƿ����
if exists(select * from syscolumns where id=object_id('����') and name='����')  
  alter table ���� drop column ����

--9 �ж����Ƿ�������
if columnproperty(object_id('table'),'col','IsIdentity')=1  
  print '������'  
else  
  print '����������'
  
SELECT * FROM sys.columns WHERE object_id=OBJECT_ID('����')  AND is_identity=1

---10 �жϱ����Ƿ��������


if exists(select * from sysindexes where id=object_id('����') and name='������')    
  print  '����'    
else    
  print  '������'

drop index ����.������ 

  

--11 �鿴���ݿ��ж���

SELECT * FROM sys.sysobjects WHERE name='������'  SELECT * FROM sys.sysobjects WHERE name='������'