

-- 1查看是否开启sqlserver 代理
SELECT * FROM sys.dm_server_services

-- 查看所有CDC作业的当前配置
EXEC sys.sp_cdc_help_jobs;

--修改  pollinginterval：轮询间隔（秒） 默认5s
EXEC sys.sp_cdc_change_job 
  @job_type = 'capture',
  @maxtrans = 1000,          -- 每个扫描周期处理的最大事务数
  @maxscans = 10,            -- 最大扫描周期数
  @continuous = 1,           -- 连续模式
  @pollinginterval = 1;      -- 轮询间隔(秒)




-- 修改参数后需要重启CDC作业生效：

EXEC sys.sp_cdc_stop_job @job_type = 'capture';
EXEC sys.sp_cdc_start_job @job_type = 'capture';



-- 查看数据库是否启用cdc
SELECT name,is_cdc_enabled FROM sys.databases WHERE is_cdc_enabled = 1;

-- 查看当前数据库表是否启用cdc
SELECT name,is_tracked_by_cdc FROM sys.tables WHERE is_tracked_by_cdc = 1;


-- InventoryItemDetail

-- 对当前数据库启用 CDC
USE wms_liku 
GO
EXECUTE sys.sp_cdc_enable_db;
GO
-- 对当前数据库禁用 CDC
USE MyDB  
GO  
EXEC sys.sp_cdc_disable_db  
GO


-- 数据库表启用和禁用 CDC
-- 启用
USE wms_liku  
GO  
EXEC sys.sp_cdc_enable_table  
@source_schema = N'dbo',  
@source_name   = N'Inventory',  
@role_name     = NULL,  
@supports_net_changes = 1  
GO 
-- 禁用
USE wms_liku  
GO  
EXEC sys.sp_cdc_disable_table  
@source_schema = N'dbo',  
@source_name   = N'MyTable',  
@capture_instance = N'dbo_MyTable'  
GO







-- 查看表 CDC 功能是否启用

SELECT  name ,
        is_tracked_by_cdc ,
        CASE WHEN is_tracked_by_cdc = 0 THEN 'CDC功能禁用'
             ELSE 'CDC功能启用'
        END 描述
FROM    sys.tables
where name ='InventoryItemDetail';

-- > 开启授权

ALTER AUTHORIZATION ON DATABASE::[MyDB] TO [sa]


SELECT DISTINCT local_tcp_port FROM sys.dm_exec_connections;












SELECT CAST(DATEDIFF(SECOND,'1970-01-01T08:00:00',  GETDATE()) AS BIGINT) * 1000 ;






select  *  from InventoryItemDetail_copy1


delete  from InventoryItem_copy1  where id not  in (
select  InventoryItemId  from InventoryItemDetail_copy1

)


delete  from Inventory_copy1  where id not  in (
select  InventoryId  from InventoryItem_copy1

)


delete  from Location_copy1  where id not  in (
select  LocationId  from Inventory_copy1

)

delete  from Laneway_copy1  where id not  in (
select  LanewayId  from Location_copy1

)




GO

select  d.Id,d.InventoryItemId,t.InventoryId,i.LocationId,l.LanewayId
 from InventoryItemDetail_copy1 d
 join InventoryItem_copy1 t on d.InventoryItemId=t.Id
 join Inventory_copy1 i on t.InventoryId=i.Id
 join Location l on i.LocationId=l.Id
 join Laneway la on l.LanewayId=la.Id
 where d.Id=509955479831328
 
select  *   from InventoryItem_copy1 where id=509955479822182
select  *   from Inventory_copy1 where id=509955479831328


update InventoryItemDetail set BatchNo='125' ,
LastModificationTime=CAST(DATEDIFF(SECOND,'1970-01-01T08:00:00',  GETDATE()) AS BIGINT) * 1000 
where id= 509955479831328

update InventoryItem_copy1 set IsLocked=1,Str1='1123',
LastModificationTime=CAST(DATEDIFF(SECOND,'1970-01-01T08:00:00',  GETDATE()) AS BIGINT) * 1000 
where id= 509955479822182

update Inventory_copy1 set IsLocked=1,Str1='1231',
LastModificationTime=CAST(DATEDIFF(SECOND,'1970-01-01T08:00:00',  GETDATE()) AS BIGINT) * 1000 
where id= 509955479759722




			
update Location_copy1 set IsLocked=1,
LastModificationTime=CAST(DATEDIFF(SECOND,'1970-01-01T08:00:00',  GETDATE()) AS BIGINT) * 1000 
where id= 509955478157328
			
			
update Laneway_copy1 set XStatus=1,
LastModificationTime=CAST(DATEDIFF(SECOND,'1970-01-01T08:00:00',  GETDATE()) AS BIGINT) * 1000 
where id= 509945476378693
			
			
			
select  *  from Laneway_copy1
			
			
			
			select  ExpiredTime from InventoryItem
			ORDER BY ExpiredTime;
			
			
			
			
									
									
									
									
									
									
									
									
									
									
									
									
									
									





















