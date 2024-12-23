 -- 在线文档 https://docs.microsoft.com/zh-cn/sql/t-sql/statements/create-index-transact-sql?view=sql-server-ver15

 -- DML（data manipulation language）： SELECT、UPDATE、INSERT、DELETE
-- DDL（data definition language）： CREATE、ALTER、DROP等，DDL主要是用在定义或改变表（TABLE）的结构
-- DCL（Data Control Language）：  设置或更改数据库用户或角色权限的语句，包括（grant,deny,revoke等）语句

-- varchar(n)类型中，n最大到8000。弱存储英文，则占一个字节，存储汉字，则占两个字节。
-- nvarchar(n)类型中，n最大到4000。无论存储英文还是汉字，都占用两个字节。

--  waitfor time '11:12:12'
-- 时间戳是指格林威治时间1970年01月01日00时00分00秒(北京时间1970年01月01日08时00分00秒)起至现在的总秒数 
-- 数据类型
-- blob ：mssql 里的timestamp对应mysql里的blob。mysql插入不需要插叙此列，会自动生成。
--        但是更新行数据，不会更新blob值。不想mssql会更新timestamp值。
-- timestamp
-- 1、公开数据库中自动生成的唯一二进制数字的数据类型。
-- 2、timestamp 通常用作给表行加版本戳的机制。
-- 3、存储大小为 8 个字节。 不可为空的 timestamp 列在语义上等价于 binary(8) 列。可为空的 timestamp 列在语义上等价于 varbinary(8) 列。这将导致在C#程序中获取到的timestamp类型则变成了byte[]类型。所以如果我们需要从数据库中获取并使用这个时间戳的话就必需经过转换。
-- 4、timestamp 数据类型只是递增的数字，不保留日期或时间。 若要记录日期或时间，请使用 datetime 数据类型。
-- 5、一个表只能有一个 timestamp 列。每次插入或更新包含 timestamp 列的行时，timestamp 列中的值均会更新。对行的任何更新都会更改 timestamp 值。
-- 、总结：SQL Server timestamp 数据类型与时间和日期无关。SQL Server timestamp 是二进制数字，它表明数据库中数据修改发生的相对顺序。实现 timestamp 数据类型最初是为了支持 
--   SQL Server 恢复算法。每次修改页时，都会使用当前的 @@DBTS 值对其做一次标记，然后 @@DBTS 加1。这样做足以帮助恢复过程确定页修改的相对次序，
--  但是 timestamp 值与时间没有任何关系。@@DBTS 返回当前数据库最后使用的时间戳值。插入或更新包含 timestamp 列的行时，将产生一个新的时间戳值。



select @@DBTS;


-- Decimal(n,m)表示数值中共有n位数，其中整数n-m位，小数m位
-- NUMERIC和DECIMAL没有区别
-- float 、double 由于不能精确表示，会丢失，用decimal

-- DateTime字段类型要用 GETDATE() ，DateTime2字段类型要用 SYSDATETIME() 。
--datetime:精确到毫秒 2020-12-15 14:13:46.507 yyyy-MM-dd HH:mm:ss.fff 
select GETDATE();
-- datetime2:精确到微秒 2020-12-15 14:13:17.7543695  yyyy-MM-dd HH:mm:ss.fffffff ，7个f，精确到0.1微秒(μs)，
select SYSDATETIME();

--普通时间转换成时间戳
SELECT DATEDIFF(S,'1970-01-01 00:00:00', GETDATE()) 
--时间戳转换成普通时间
SELECT DATEADD(S,1557493321,'1970-01-01 00:00:00')  
select GETDATE();

-- 时间转字符串
--120 不带毫秒
--只去前10位：年月日
select CONVERT(varchar(10),GETDATE(),120);
select CONVERT(varchar(100),GETDATE(),120);
--121带毫秒
 select CONVERT(varchar(100), GETDATE(), 21)
 select CONVERT(varchar(100), GETDATE(), 121)

SELECT *  FROM  wms.dbo.product;
waitfor  delay '00:00:10' --类似Thread.Sleep
SELECT  COUNT(id)[Count] FROM wms.dbo.product;


SELECT *  FROM  wms.dbo.product;
 waitfor time '22:20' --在22:20执行
SELECT  COUNT(id)[Count] FROM wms.dbo.product;

--变量声明,赋值
declare @count int;
-- select @count=COUNT(ID) from WMS.dbo.Product;
set @count=30;
select @count 'Count';

 select concat('asss','ddd');

 select  'asss'+'ddd';

 -- 谓词，通常来说是函数的一种，是需要满足特定条件的函数。该条件就是“返回值是真值”，即返回的值必须为TRUE/FALSE/UNKNOWN。

 -- 取值为 TRUE、FALSE 或 UNKNOWN 的表达式。 
 --谓词用于 WHERE 子句和 HAVING 子句的搜索条件中，还用于 FROM子句的联接条件以及需要布尔值的其他构造(函数)中。

 --使用布尔运算符（AND、OR 和 NOT）。

 -- 显示估计的执行计划(P) 快捷键:Ctrl + L


USE [WMSData]
GO
-- 创建外键约束
ALTER TABLE [dbo].[Check]  WITH NOCHECK ADD  CONSTRAINT [FK_Check_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO

-- 删除外键约束
ALTER TABLE [dbo].[Check]   DROP CONSTRAINT  [FK_Check_Product]  

-- 禁用外键约束
ALTER TABLE [dbo].[Check] NOCHECK CONSTRAINT [FK_Check_Product]
-- 启用外键约束
ALTER TABLE [dbo].[Check] CHECK CONSTRAINT [FK_Check_Product]

GO


-- 有外键引用的表不能TRUNCATR,只能DELETE, 除非删除外键约束.


--无法截断表 'WMSData.dbo.Product'，因为该表正由 FOREIGN KEY 约束引用。
select fk.name,fk.object_id,OBJECT_NAME(fk.parent_object_id) as referenceTableName
from sys.foreign_keys as fk
join sys.objects as o on fk.referenced_object_id=o.object_id
where o.name='Product'
go



USE [WMSData]
GO
-- 创建外键约束
ALTER TABLE [dbo].InOutStock  WITH NOCHECK ADD  CONSTRAINT FK_InOutStock_Product FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ALTER TABLE [dbo].OrderDetail  WITH NOCHECK ADD  CONSTRAINT FK_OrderDetail_Product FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ALTER TABLE [dbo].[Check]  WITH NOCHECK ADD  CONSTRAINT [FK_Check_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
GO

-- 删除外键约束
ALTER TABLE [dbo].[Check]   DROP CONSTRAINT  [FK_Check_Product]  
ALTER TABLE [dbo].InOutStock   DROP CONSTRAINT  FK_InOutStock_Product  
ALTER TABLE [dbo].OrderDetail   DROP CONSTRAINT  FK_OrderDetail_Product  

-- TRUNCATE 前先删除所有的外键约束
TRUNCATE TABLE  WMSData.dbo.Product



  --LIKE内容含有通配符
 SELECT * FROM WMS.dbo.Product WHERE  [ProductName]  LIKE '%\_%'ESCAPE '\';

  -- 类型转换
  select convert(int,'1')+1;

  select cast(1 as varchar)+'12';

  -- 获取年月
   select   GetDate()

 select  DateName(YEAR,GETDATE())
 select  DateName(MONTH,GETDATE())
 SELECT year(GETDATE()), month(GETDATE()), day(GETDATE())


 select        count(case when YEAR(CreateDate)= YEAR(GETDATE()) and 
                               Month(CreateDate)= Month(GETDATE()) then CreateDate 
                         else null
                         end
                   ) MonthAddCustomerSum,
              count(case when  YEAR(CreateDate)= YEAR(GETDATE()) and 
                               Month(DATEADD(Month,3, CreateDate))>= Month(GETDATE()) then CreateDate 
                          else null
                          end
                   ) ThreeMonthCustomerSum,
              count(case when YEAR(CreateDate)= YEAR(GETDATE())  then CreateDate 
                         else null
                         end
                   ) YearAddCustomerSum
    from [CustomerRelationship_AH].[dbo].[SellerSubject]




	-- 事务隔离级别
	-- 默认  Read Committed  
	-- 产生副作用表

	-- 隔离级别                    脏读            不可重复读取          幻读
	-- Read Uncommitted            是                  是                 是
	-- Read Committed              否                  是                 是
	-- Repeatable Read             否                  否                 是
	-- Snapshot                    否                  否                 否
	-- Serializable                否                  否                 否















