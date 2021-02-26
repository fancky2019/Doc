-- sql企业版才支持分区：安装填写激活码填写企业版的激活码：FH666-Y346V-7XFQ3-V69JM-RHW28


-- Microsoft SQL Server 2012 - 11.0.2100.60 (X64)   Feb 10 2012 19:39:15   Copyright (c) Microsoft Corporation  Enterprise Edition: Core-based Licensing (64-bit) on Windows NT 6.1 <X64> (Build 7601: Service Pack 1) 
SELECT @@VERSION

select count(*)  from WMSData.dbo.Product;

select *  from WMSData.dbo.Product;

SELECT DATE, COUNT(*) 'Count' FROM (
SELECT  CONVERT(varchar(10),CreateTime,120) 'Date'  FROM WMSData.dbo.Product
) AS t
GROUP BY DATE
ORDER BY DATE

-- 步骤:
-- 1、创建数据库文件组
-- 2、创建数据库文件
-- 3、创建分区函数
-- 4、创建分区方案
-- 5、创建分区表


-- sql 脚本
--  添加文件组
alter database WMSData add filegroup WMSDataFileGroup20023;

-- 先删除文件 再删除文件组
ALTER DATABASE WMSData REMOVE FILEGROUP WMSDataFileGroup20023;

ALTER DATABASE WMSData REMOVE FILE WMSDataFile20023;

-- 添加文件
ALTER DATABASE WMSData ADD FILE(NAME=N'WMSDataFile20023',FILENAME=N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\WMSDataFile200023.ndf',SIZE=5MB, MAXSIZE=UNLIMITED,FILEGROWTH=5MB)
TO FILEGROUP WMSDataFileGroup20023;

-- 查看文件组
 select  *  from sys.filegroups;

 -- 创建分区
 -- 分区函数;注意分区数比文件数要小1即文件数=分区数+1。
 --  RIGHT 边界值属于右侧，默认左侧
 -- 小于
CREATE PARTITION FUNCTION Partition_Function_Product_CreateTime ( DATETIME )
AS RANGE RIGHT
FOR VALUES(
'2000-01-01','2001-01-01', '2002-01-01','2003-01-01','2004-01-01','2005-01-01','2006-01-01','2007-01-01','2008-01-01','2009-01-01', 
'2010-01-01','2011-01-01','2012-01-01','2013-01-01','2014-01-01','2015-01-01','2016-01-01','2017-01-01','2018-01-01','2019-01-01',
'2020-01-01','2021-01-01','2022-01-01'
);

-- 删除
-- drop partition function <分区函数名>

-- 分区方案：绑定分区函数和文件组有点类似RabbitMQ的交换机、队列和路由Key关系
-- <2000-01-01在文件组WMSDataFileGroup20000
-- [2000-01-01,2001-01-01)在文件组WMSDataFileGroup20001
-- [2022-01-01,)在文件组WMSDataFileGroup20023
CREATE PARTITION Scheme Partition_Scheme_Product_CreateTime
AS PARTITION Partition_Function_Product_CreateTime
TO (
WMSDataFileGroup20000, WMSDataFileGroup20001, WMSDataFileGroup20002, WMSDataFileGroup20003, WMSDataFileGroup20004,WMSDataFileGroup20005, 
WMSDataFileGroup20006, WMSDataFileGroup20007, WMSDataFileGroup20008, WMSDataFileGroup20009, WMSDataFileGroup20010,WMSDataFileGroup20011, 
WMSDataFileGroup20012, WMSDataFileGroup20013, WMSDataFileGroup20014, WMSDataFileGroup20015, WMSDataFileGroup20016,WMSDataFileGroup20017, 
WMSDataFileGroup20018, WMSDataFileGroup20019, WMSDataFileGroup20020, WMSDataFileGroup20021, WMSDataFileGroup20022, WMSDataFileGroup20023
)

-- 查看已创建的分区方案：
SELECT * FROM sys.partition_schemes;
go

-- 创建分区表

-- 创建新的表
-- 创建分区表
CREATE TABLE [dbo].[ProductPartition](
	[ID] [int] IDENTITY(1,1) NOT NULL ,
	[GUID] [uniqueidentifier] NOT NULL,
	[StockID] [int] NULL,
	[BarCodeID] [int] NULL,
	[SkuID] [int] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductStyle] [nvarchar](100) NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[Status] [smallint] NOT NULL,
	[Count] [int] NOT NULL,
	[ModifyTime] [datetime] NULL,
	[TimeStamp] [timestamp] NULL,

) ON  Partition_Scheme_Product_CreateTime (CreateTime ) 

GO


-- 无法删除索引 'PK_Product'，因为该索引强制使用表或索引视图 'Product' 的全文键。
-- 删除主键索引时候要把该表作为外键的键全部删除

-- 在已有表中添加分区:右键到要分区的表--- >> 存储 --- >> 创建分区 --- >>显示向导视图 --- >> 下一步 --- >> 下一步。
-- 设置分区:将文件组由primary移动到分区架构
ALTER TABLE  WMSData.dbo.Product
DROP CONSTRAINT PK_Product -- 主键约束在Primary上
WITH(
MOVE TO  Partition_Scheme_Product_CreateTime (CreateTime ) 
)
--设计器上添加主键

-- 查看分区数据
SELECT $PARTITION.Partition_Function_Product_CreateTime(CreateTime) AS 分区编号, COUNT(1) AS 记录数 
FROM WMSData.dbo.Product
GROUP BY $PARTITION.Partition_Function_Product_CreateTime(CreateTime)

-- 查看数据对应的分区
SELECT $PARTITION.Partition_Function_Product_CreateTime(CreateTime) AS 分区编号,CreateTime 
FROM WMSData.dbo.Product




-- 无法删除索引 'PK_Product'，因为该索引强制使用表或索引视图 'Product' 的全文键。
-- 删除主键索引时候要把该表作为外键的键全部删除




--问题: 执行超时已过期。完成操作之前已超时或服务器未响应。
-- 解决: 工具--选项--设计器--表设计器和数据库设计器--超过此时间后事务超时(R):时间设置大

CREATE TABLE [dbo].[Product_UnPartition](
	[ID] [int] IDENTITY(1,1) NOT NULL ,
	[GUID] [uniqueidentifier] NOT NULL,
	[StockID] [int] NULL,
	[BarCodeID] [int] NULL,
	[SkuID] [int] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductStyle] [nvarchar](100) NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[Status] [smallint] NOT NULL,
	[Count] [int] NOT NULL,
	[ModifyTime] [datetime] NULL,
	[TimeStamp] [timestamp] NULL,
	 CONSTRAINT [PK_Product_UnPartition] PRIMARY KEY NONCLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)

-- 29s
insert into [Product_UnPartition]
      ( [StockID] ,[BarCodeID],[SkuID] ,[ProductName],[ProductStyle] ,[Price] ,[CreateTime]
      ,[Status] ,[Count] ,[ModifyTime]
	  )
	  select  
      [StockID] ,[BarCodeID],[SkuID] ,[ProductName],[ProductStyle] ,[Price] ,[CreateTime]
      ,[Status] ,[Count] ,[ModifyTime]
	  from [Product];


 SELECT $PARTITION.Partition_Function_Product_CreateTime(CreateTime) AS 分区编号, COUNT(1) AS 记录数 
FROM WMSData.dbo.[Product_UnPartition]
GROUP BY $PARTITION.Partition_Function_Product_CreateTime(CreateTime)
    

	-- 查询分区数据
	select * from  [Product_UnPartition]
    where $partition.Partition_Function_Product_CreateTime(CreateTime)=3

	SELECT $PARTITION.Partition_Function_Product_CreateTime(CreateTime) AS 分区编号 
     FROM [Product_UnPartition]
   GROUP BY $PARTITION.Partition_Function_Product_CreateTime(CreateTime)


	SELECT distinct t.* FROM sys.partitions AS p
	JOIN sys.tables AS t
	ON p.object_id = t.object_id
	WHERE p.partition_id IS NOT NULL
	AND t.name = 'Product';


   SELECT distinct p.*  FROM sys.partitions AS p
	JOIN sys.tables AS t
	ON p.object_id = t.object_id
	WHERE p.partition_id IS NOT NULL
	AND t.name = 'Product_UnPartition';


	SELECT distinct p.object_id ,t.object_id FROM sys.partitions AS p
	JOIN sys.tables AS t
	ON p.object_id = t.object_id
	WHERE p.partition_id IS NOT NULL
	AND t.name = 'Check';






	--truncate table WMSData.dbo.[Product]

	-- 	truncate table Test.dbo.[Product_UnPartition]  

	go


	-- 7min
	insert into Test.dbo.[Product_UnPartition]
      ( guid, [StockID] ,[BarCodeID],[SkuID] ,[ProductName],[ProductStyle] ,[Price] ,[CreateTime]
      ,[Status] ,[Count] ,[ModifyTime]
	  )
	  select  
     guid, [StockID] ,[BarCodeID],[SkuID] ,[ProductName],[ProductStyle] ,[Price] ,[CreateTime]
      ,[Status] ,[Count] ,[ModifyTime]
	  from WMSData.dbo.product;


	SELECT  count(ID)  FROM WMSData.dbo.[Product] ;

	SELECT  count(ID)  FROM Test.dbo.[Product_UnPartition] ;



		SELECT  *  FROM WMSData.dbo.[Product_UnPartition]  WHERE CreateTime>='2017-01-01';

	SELECT  *  FROM WMSData.dbo.[Product] WHERE CreateTime>='2017-01-01';

	SELECT  *  FROM Test.dbo.[Product_UnPartition]  WHERE CreateTime>='2017-01-01';


	SELECT  *  FROM WMSData.dbo.[Product]  WHERE CreateTime='2017-05-29 22:28:02.000';

	SELECT  *  FROM Test.dbo.[Product_UnPartition] WHERE CreateTime='2017-05-29 22:28:02.000';

	   SELECT * FROM sys.partitions 

