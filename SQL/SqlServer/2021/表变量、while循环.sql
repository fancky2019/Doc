
----声明表变量
--declare @SaleRemarkCount table
--(
--ID int ,  
---- ID int  identity (1,1) primary key,  
--SaleID nvarchar(100),
--SaleName int,
--RemarkCount int  DEFAULT 0,
--[Year] int,
--[Month] int
--);
--declare @YearConst int =2021 ;  
--declare @rowID int =1 ;   
--declare @n int =1
--while @n<=12
--begin
--insert into @SaleRemarkCount(ID,[Year] ,[Month] ) values (@rowID,@YearConst,@n);
--set @rowID+=1; --set 赋值
--set @n+=1; --set 赋值
--end

--select  *  from @SaleRemarkCount


declare @SaleRemarkCount table
( 
 ID int  identity (1,1) primary key,  
SaleID nvarchar(100),
SaleName int,
RemarkCount int  DEFAULT 0,
[Year] int,
[Month] int
);
declare @YearConst int =2021 ;   
declare @n int =1
while @n<=12
begin
insert into @SaleRemarkCount([Year] ,[Month] ) values (@YearConst,@n);
set @n+=1; --set 赋值
end

select  *  from @SaleRemarkCount






