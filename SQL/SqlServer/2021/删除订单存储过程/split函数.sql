----����һ����ʱ����Ϊ����
--create function split(@str varchar(2000),@split varchar(2))
--returns @t_split table(col varchar(20))
--as
--begin
-- --ѭ���ҵ��ַ����е�һ��','������
-- while(charindex(@split,@str)<>0)
-- begin
--  --����һ��','֮ǰ���ַ���Ԫ������ʱ����
--  insert @t_split(col) values(substring(@ids,1,charindex(@split,@ids)-1))
--  --����һ��','������ַ������¸���@ids
--  set @str=stuff(@str,1,charindex(@split,@ids),'')
-- end
-- --�����һ���ַ���Ԫ�������(�Ѿ�û��',')
-- insert @t_split(col) values(@ids)
-- return
--end
--go



--select * from f_split('1,2,3,4,5,6,7',',')
--drop function f_split

use [NewClassesAdmin]
go
if exists (select * from dbo.sysobjects where id = object_id(N'split') and xtype in (N'FN', N'IF', N'TF'))
-- ɾ������
drop function [dbo].[split]
GO
Create FUNCTION dbo.split (
    @String VARCHAR(MAX),
    @Delimiter VARCHAR(MAX)
) RETURNS @temptable TABLE (items VARCHAR(MAX)) AS
BEGIN
    DECLARE @idx INT=1
    DECLARE @slice VARCHAR(MAX) 
    IF LEN(@String) < 1 OR LEN(ISNULL(@String,'')) = 0
        RETURN
    WHILE @idx != 0
    BEGIN
        SET @idx = CHARINDEX(@Delimiter,@String)
        IF @idx != 0
            SET @slice = LEFT(@String,@idx - 1)
        ELSE
            SET @slice = @String
        IF LEN(@slice) > 0
            INSERT INTO @temptable(items) VALUES(@slice)
        SET @String = RIGHT (@String, LEN(@String) - @idx)
        IF LEN(@String) = 0
            BREAK
    END
    RETURN
END
