
use WMS
GO
-- READ UNCOMMITTED;�൱��nolock ����select��update��delete��Insert
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
 GO
 begin tran lockTest
 -- ����ID=50��һ��
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --����������
  select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go





use WMS
GO
--READ COMMITTED(Ĭ��):��� �����������ɾ�Ĳ�
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
 GO
 begin tran lockTest
 -- ����ID=50��һ��
  --select *  from  [WMS].[dbo].[Product] where ID=50
 --����������
  select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go




use WMS
GO
--REPEATABLE READ:��� ���,���ظ���ȡ������update��delete,����select��insert
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
 GO
 begin tran lockTest
 -- ����ID=50��һ��
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --����������
 -- select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go


use WMS
GO
--SERIALIZABLE���൱��holdlock��:��� ���,���ظ���ȡ���ö�������update��delete��insert,����select
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
 GO
 begin tran lockTest
 -- ����ID=50��һ��
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --����������
  select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go


use WMS
GO
 --�轫 READ_COMMITTED_SNAPSHOT ����Ϊ ON����Ĭ��ΪOFF
--SNAPSHOT���൱��holdlock��:��� ���,���ظ���ȡ���ö�������update��delete��insert,����select
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
 GO
 begin tran lockTest
 -- ����ID=50��һ��
 -- select *  from  [WMS].[dbo].[Product] where ID=50
 --����������
  select *  from  [WMS].[dbo].[Product]
  --select COUNT(ID) from  [WMS].[dbo].[Product]
  waitfor  delay '00:00:10' --����Thread.Sleep
  commit tran lockTest
  go