
-- liku

USE liku 
GO
EXECUTE sys.sp_cdc_enable_db;
GO



USE liku  
GO  
EXEC sys.sp_cdc_enable_table  
@source_schema = N'dbo',  
@source_name   = N'Laneway',  
@role_name     = NULL,  
@supports_net_changes = 1  ;
GO

USE liku  
GO  
EXEC sys.sp_cdc_enable_table  
@source_schema = N'dbo',  
@source_name   = N'Location',  
@role_name     = NULL,  
@supports_net_changes = 1  ;
GO


USE liku  
GO  
EXEC sys.sp_cdc_enable_table  
@source_schema = N'dbo',  
@source_name   = N'Inventory',  
@role_name     = NULL,  
@supports_net_changes = 1  ;
GO



USE liku  
GO  
EXEC sys.sp_cdc_enable_table  
@source_schema = N'dbo',  
@source_name   = N'InventoryItem',  
@role_name     = NULL,  
@supports_net_changes = 1  ;
GO



USE liku  
GO  
EXEC sys.sp_cdc_enable_table  
@source_schema = N'dbo',  
@source_name   = N'InventoryItemDetail',  
@role_name     = NULL,  
@supports_net_changes = 1  ;
GO




-- update InventoryItemDetail set BatchNo='125' ,
-- LastModificationTime=CAST(DATEDIFF(SECOND,'1970-01-01T08:00:00',  GETDATE()) AS BIGINT) * 1000 
-- where id= 509955479831328






