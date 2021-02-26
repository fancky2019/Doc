-- sql��ҵ���֧�ַ�������װ��д��������д��ҵ��ļ����룺FH666-Y346V-7XFQ3-V69JM-RHW28


-- Microsoft SQL Server 2012 - 11.0.2100.60 (X64)   Feb 10 2012 19:39:15   Copyright (c) Microsoft Corporation  Enterprise Edition: Core-based Licensing (64-bit) on Windows NT 6.1 <X64> (Build 7601: Service Pack 1) 
SELECT @@VERSION

select count(*)  from WMSData.dbo.Product;

select *  from WMSData.dbo.Product;

SELECT DATE, COUNT(*) 'Count' FROM (
SELECT  CONVERT(varchar(10),CreateTime,120) 'Date'  FROM WMSData.dbo.Product
) AS t
GROUP BY DATE
ORDER BY DATE

-- ����:
-- 1���������ݿ��ļ���
-- 2���������ݿ��ļ�
-- 3��������������
-- 4��������������
-- 5������������


-- sql �ű�
--  ����ļ���
alter database WMSData add filegroup WMSDataFileGroup20023;

-- ��ɾ���ļ� ��ɾ���ļ���
ALTER DATABASE WMSData REMOVE FILEGROUP WMSDataFileGroup20023;

ALTER DATABASE WMSData REMOVE FILE WMSDataFile20023;

-- ����ļ�
ALTER DATABASE WMSData ADD FILE(NAME=N'WMSDataFile20023',FILENAME=N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\WMSDataFile200023.ndf',SIZE=5MB, MAXSIZE=UNLIMITED,FILEGROWTH=5MB)
TO FILEGROUP WMSDataFileGroup20023;

-- �鿴�ļ���
 select  *  from sys.filegroups;

 -- ��������
 -- ��������;ע����������ļ���ҪС1���ļ���=������+1��
 --  RIGHT �߽�ֵ�����Ҳ࣬Ĭ�����
 -- С��
CREATE PARTITION FUNCTION Partition_Function_Product_CreateTime ( DATETIME )
AS RANGE RIGHT
FOR VALUES(
'2000-01-01','2001-01-01', '2002-01-01','2003-01-01','2004-01-01','2005-01-01','2006-01-01','2007-01-01','2008-01-01','2009-01-01', 
'2010-01-01','2011-01-01','2012-01-01','2013-01-01','2014-01-01','2015-01-01','2016-01-01','2017-01-01','2018-01-01','2019-01-01',
'2020-01-01','2021-01-01','2022-01-01'
);

-- ɾ��
-- drop partition function <����������>

-- �����������󶨷����������ļ����е�����RabbitMQ�Ľ����������к�·��Key��ϵ
-- <2000-01-01���ļ���WMSDataFileGroup20000
-- [2000-01-01,2001-01-01)���ļ���WMSDataFileGroup20001
-- [2022-01-01,)���ļ���WMSDataFileGroup20023
CREATE PARTITION Scheme Partition_Scheme_Product_CreateTime
AS PARTITION Partition_Function_Product_CreateTime
TO (
WMSDataFileGroup20000, WMSDataFileGroup20001, WMSDataFileGroup20002, WMSDataFileGroup20003, WMSDataFileGroup20004,WMSDataFileGroup20005, 
WMSDataFileGroup20006, WMSDataFileGroup20007, WMSDataFileGroup20008, WMSDataFileGroup20009, WMSDataFileGroup20010,WMSDataFileGroup20011, 
WMSDataFileGroup20012, WMSDataFileGroup20013, WMSDataFileGroup20014, WMSDataFileGroup20015, WMSDataFileGroup20016,WMSDataFileGroup20017, 
WMSDataFileGroup20018, WMSDataFileGroup20019, WMSDataFileGroup20020, WMSDataFileGroup20021, WMSDataFileGroup20022, WMSDataFileGroup20023
)

-- �鿴�Ѵ����ķ���������
SELECT * FROM sys.partition_schemes;
go

-- ����������

-- �����µı�
-- ����������
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


-- �޷�ɾ������ 'PK_Product'����Ϊ������ǿ��ʹ�ñ��������ͼ 'Product' ��ȫ�ļ���
-- ɾ����������ʱ��Ҫ�Ѹñ���Ϊ����ļ�ȫ��ɾ��

-- �����б�����ӷ���:�Ҽ���Ҫ�����ı�--- >> �洢 --- >> �������� --- >>��ʾ����ͼ --- >> ��һ�� --- >> ��һ����
-- ���÷���:���ļ�����primary�ƶ��������ܹ�
ALTER TABLE  WMSData.dbo.Product
DROP CONSTRAINT PK_Product -- ����Լ����Primary��
WITH(
MOVE TO  Partition_Scheme_Product_CreateTime (CreateTime ) 
)
--��������������

-- �鿴��������
SELECT $PARTITION.Partition_Function_Product_CreateTime(CreateTime) AS �������, COUNT(1) AS ��¼�� 
FROM WMSData.dbo.Product
GROUP BY $PARTITION.Partition_Function_Product_CreateTime(CreateTime)

-- �鿴���ݶ�Ӧ�ķ���
SELECT $PARTITION.Partition_Function_Product_CreateTime(CreateTime) AS �������,CreateTime 
FROM WMSData.dbo.Product




-- �޷�ɾ������ 'PK_Product'����Ϊ������ǿ��ʹ�ñ��������ͼ 'Product' ��ȫ�ļ���
-- ɾ����������ʱ��Ҫ�Ѹñ���Ϊ����ļ�ȫ��ɾ��




--����: ִ�г�ʱ�ѹ��ڡ���ɲ���֮ǰ�ѳ�ʱ�������δ��Ӧ��
-- ���: ����--ѡ��--�����--������������ݿ������--������ʱ�������ʱ(R):ʱ�����ô�

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


 SELECT $PARTITION.Partition_Function_Product_CreateTime(CreateTime) AS �������, COUNT(1) AS ��¼�� 
FROM WMSData.dbo.[Product_UnPartition]
GROUP BY $PARTITION.Partition_Function_Product_CreateTime(CreateTime)
    

	-- ��ѯ��������
	select * from  [Product_UnPartition]
    where $partition.Partition_Function_Product_CreateTime(CreateTime)=3

	SELECT $PARTITION.Partition_Function_Product_CreateTime(CreateTime) AS ������� 
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

