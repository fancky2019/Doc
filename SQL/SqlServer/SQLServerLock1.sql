--        ���������1��ȡ����2�޸ĵ����ݺ�����2�ع���
--�����ظ���ȡ������1���ζ�ȡ�����ݲ�һ�������ζ�ȡ�м䱻����2�޸��ˡ�
--        �ö�������1���β�ѯ��������һ����������2����ɾ���ˡ�


--      �����A�����ȡB����δ�ύ�ĸ��ģ����B�ع���
--���ظ���ȡ��A�������ζ�ȡ�����ݲ�һ�������ζ�ȡ�ڼ䱻����B���ˡ�
--      �ö�������ִ�еĲ�ѯ�����һ�����ڼ�����B�����ɾ�������ˡ�
--  ��ʧ���£�A������µ����ݱ�B����ĸ��¸�����ˡ�




-- ����ܾ�ȷ���о����У�������������






--UPDLOCK����ȡ��¼ʱ���Զ�ȡ���ļ�¼���ϸ��������Ӷ��������ļ�¼���������߳����ǲ��ܸ��ĵ�ֻ�ܵȱ��̵߳������������ܸ���.
--������
--updlock�������������ڼ�,����������update��delete,���ǿ��Բ���,�����ö�������������Զ�ȡ
  go
  begin tran lockTest
 -- ����ID=50��һ��
  select *  from  [WMS].[dbo].[Product] with(updlock) where ID=50
 --����������
  --select *  from  [WMS].[dbo].[Product] with(updlock)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(updlock)
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go

  --holdlock ���� ������
  --holdlock�������������ڼ�,����������insert��update��delete������������Զ�ȡ
    begin tran lockTest
 -- ����ID=50��һ��
 -- select *  from  [WMS].[dbo].[Product] with(holdlock) where ID=50
 --����������
  select *  from  [WMS].[dbo].[Product] with(holdlock)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(holdlock)
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go



--TABLOCKX ���� ������
--TABLOCKX :�������������ڼ�,����������select��insert��update��delete��
    begin tran lockTest
 -- ����ID=50��һ��
  select *  from  [WMS].[dbo].[Product] with(TABLOCKX) where ID=50
 --����������
  --select *  from  [WMS].[dbo].[Product] with(TABLOCKX)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(TABLOCKX)
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go

 -- XLOCK ָ�����������������ֵ�������ɡ�
--XLOCK :�������������ڼ�,����������update��ɾ��������select��insert
    begin tran lockTest
 -- ����ID=50��һ��
 -- select *  from  [WMS].[dbo].[Product] with(XLOCK) where ID=50
 --����������
  select *  from  [WMS].[dbo].[Product] with(tablock,XLOCK)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(XLOCK)
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go




 --tablock ���� ������
 --tablock:SQL Server �������������ù�����ֱ����"�������"�� ���ѡ�֤��������ֻ�ܶ�ȡ�������޸����ݡ�
    begin tran lockTest
 -- ����ID=50��һ��
 -- select *  from  [WMS].[dbo].[Product] with(tablock) where ID=50
 --����������
  select *  from  [WMS].[dbo].[Product] with(tablock,XLOCK)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(tablock)
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go

 -- NOLOCK :������,����������ɾ�Ĳ�
begin tran lockTest
 -- ����ID=50��һ��
  select *  from  [WMS].[dbo].[Product] with(NOLOCK) where ID=50
 --����������
  --select *  from  [WMS].[dbo].[Product] with(NOLOCK)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(NOLOCK)
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go



  --PAGLOCK :SQLServer Ĭ����
 begin tran lockTest
 -- ����ID=50��һ��
 -- select *  from  [WMS].[dbo].[Product] with(PAGLOCK) where ID=50
 --����������
  select *  from  [WMS].[dbo].[Product] with(PAGLOCK,holdlock)
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(PAGLOCK)
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go



 --ROWLOCK  
 begin tran lockTest
 -- ����ID=50��һ��
 -- select *  from  [WMS].[dbo].[Product] with(ROWLOCK ) where ID=50
 --����������
  select *  from  [WMS].[dbo].[Product] with(ROWLOCK,holdlock )
  --select COUNT(ID) from  [WMS].[dbo].[Product] with(ROWLOCK )
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go






 --��ʧ����:һ�����񸲸���һ�����������,���:�汾��(version�ֶΡ�timestamp)
 --���¼���
 begin tran lockTest
 --����������
  update [WMS].[dbo].[Product] with(updlock) set ProductName='updlock1' where ID=50
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go


  --ɾ������
  begin tran lockTest
 --����������
  delete  from [WMS].[dbo].[Product]  with(updlock)  where ID=2118
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go


use wms
go
begin tran tranTest
--ִ�гɹ�
INSERT INTO [dbo].[Product] ([GUID] ,[StockID]  ,[BarCodeID]
           ,[SkuID]  ,[ProductName] ,[ProductStyle],[Price] ,[CreateTime]
           ,[Status] ,[Count] ,[ModifyTime])
     VALUES
           (NEWID() ,1 ,null ,1   ,'ProductNameSuccess' ,null ,11  ,GETDATE() ,1 ,1 ,GETDATE())
--ִ��ʧ��,��������ʧ��,�Զ��ع�
--ִ�гɹ�,�����ύ
INSERT INTO [dbo].[Product] ([GUID] ,[StockID]  ,[BarCodeID]
           ,[SkuID]  ,[ProductName] ,[ProductStyle],[Price] ,[CreateTime]
           ,[Status] ,[Count] ,[ModifyTime])
     VALUES
           (NEWID() ,1 ,null ,1   ,'ProductNameFail' ,null ,11  ,GETDATE() ,1 )
commit tran tranTest
go


  select *  from  [WMS].[dbo].[Product] 



use Test
go
begin try
    begin  tran Process11
		update [dbo].[Person] set name='����' where id=2;
		 waitfor delay '00:00:20';
   commit tran Process11
end try
begin catch
 ROLLBACK TRAN Process11
end catch



-- 
select request_session_id spid,OBJECT_NAME(resource_associated_entity_id) tableName
from sys.dm_tran_locks where resource_type='OBJECT'


-- �鿴����������Ϣ  
-- request_mode �ֶ� IX��
-- request_type �ֶ� LOCK
select *  from sys.dm_tran_locks where resource_type='OBJECT'



  DBCC TRACEON(1222,-1) ;
  DBCC TRACESTATUS (1222, -1) ;
  DBCC TRACEOFF (1222,-1) ;





  -- SET LOCK_TIMEOUT timeout_period(��λΪ����)���趨������ʱ��Ĭ������£����ݿ�û�г�ʱ����(timeout_periodֵΪ-1��������SELECT @@LOCK_TIMEOUT���鿴��ֵ���������ڵȴ�)��

  SELECT @@LOCK_TIMEOUT;


use Test
go
update [dbo].[Job] set name='Process2' where id=2;

