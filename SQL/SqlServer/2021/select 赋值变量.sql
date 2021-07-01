declare @JuniorSaleId nvarchar(50);
declare @SysUserGuid uniqueidentifier;
set @JuniorSaleId='lijp'; 
select  @SysUserGuid=SysUserGuid  from [NewClassesAdmin].[dbo].[SysUser] where AdminUserId=@JuniorSaleId;
select @SysUserGuid SysUserGuid;