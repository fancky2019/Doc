--���������
declare @product table
(
ID int ,
ProductName nvarchar(100),
RowID int
);
--������
declare @ProductName nvarchar(500);
declare @rowID int =1;
declare @ID int ;
--�����α�
declare Product_cursor cursor
for  select  ID,ProductName  from Product;

open Product_cursor
--���α����ȶ�ȡ
 FETCH NEXT FROM product_cursor INTO @ID,@ProductName
  WHILE (@@FETCH_STATUS = 0)--�ж��Ƿ��ȡ��
  begin

    insert into @product values (@ID,@ProductName,@rowID)
    set @rowID+=1;
     --���α��������ȡ
     FETCH NEXT FROM product_cursor INTO @ID,@ProductName
  end

select *  from @product

close  Product_cursor
--�ͷ��α�
DEALLOCATE Product_cursor

--SELECT  *  from [dbo].[Product]
