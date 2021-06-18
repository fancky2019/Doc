--声明表变量
declare @product table
(
ID int ,
ProductName nvarchar(100),
RowID int
);
--声明列
declare @ProductName nvarchar(500);
declare @rowID int =1;
declare @ID int ;
--声明游标
declare Product_cursor cursor
for  select  ID,ProductName  from Product;

open Product_cursor
--从游标里先读取
 FETCH NEXT FROM product_cursor INTO @ID,@ProductName
  WHILE (@@FETCH_STATUS = 0)--判断是否读取完
  begin

    insert into @product values (@ID,@ProductName,@rowID)
    set @rowID+=1;
     --从游标里继续读取
     FETCH NEXT FROM product_cursor INTO @ID,@ProductName
  end

select *  from @product

close  Product_cursor
--释放游标
DEALLOCATE Product_cursor

--SELECT  *  from [dbo].[Product]
