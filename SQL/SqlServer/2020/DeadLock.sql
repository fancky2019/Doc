

-- ����1222���٣�����log���ӡ��������

-- ����1222����
  DBCC TRACEON(1222,-1) ;
  DBCC TRACEOFF (1222,-1) ;

-- �鿴���ø���״̬
  DBCC TRACESTATUS (1222, -1) ;




-- �������1������ӵ�в������µ���������

  -- SET LOCK_TIMEOUT timeout_period(��λΪ����)���趨������ʱ��Ĭ������£����ݿ�û�г�ʱ����(timeout_periodֵΪ-1��������SELECT @@LOCK_TIMEOUT���鿴��ֵ���������ڵȴ�)��

  SELECT @@LOCK_TIMEOUT;


--����1��

begin tran Process1
use Test
go
		update [dbo].[Person] set name='Process1' where id=2;
		waitfor delay '00:00:20';
		update [dbo].[Job] set name='Process1' where id=2;
commit tran Process1



--����2��

begin tran Process2
use Test
go
		update [dbo].[Job] set name='Process2' where id=2;
		waitfor delay '00:00:20';
		update [dbo].[Person] set name='Process2' where id=2
commit tran Process2


--  ִ�н����Process1 �����ˣ�Process2ִ�гɹ���
-- Process1���������

--(1 ����Ӱ��)
--��Ϣ 1205������ 13��״̬ 51���� 4 ��
--����(���� ID 60)����һ�����̱������� �� ��Դ�ϣ������ѱ�ѡ����������Ʒ�����������и�����



-- ��ѯ���� Process1 ��Ȼִ��ʧ�ܣ���������û�лع���ִ���˸�����[Person]��



select *  from [dbo].[Person];

select *  from [dbo].[Job];

--����1

use Test
go
begin try
    begin  tran Process11
		update [dbo].[Person] set name='Process11' where id=2;
		waitfor delay '00:00:20';
		update [dbo].[Job] set name='Process11' where id=2;
   commit tran Process11
end try
begin catch
 ROLLBACK TRAN Process11
end catch

--����2
use Test
go
begin try
    begin  tran Process22
		update [dbo].[Job] set name='Process22' where id=2;
		waitfor delay '00:00:20';
		update [dbo].[Person] set name='Process22' where id=2
   commit tran Process22
end try
begin catch
 ROLLBACK TRAN Process22
end catch












-- �������2:����ת��ʱ���ֽ���������

-- �������ͬʱִ������ű�

use Test
go
begin tran Process3
select * from [dbo].[Person] where id=2;
waitfor delay '00:00:15';
update  [dbo].[Person] set name=name+'Process3' where id=2;
commit tran Process3

-- ���ǲ��Բ�δ��������




