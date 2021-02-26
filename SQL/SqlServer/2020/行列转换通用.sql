USE [Demo]
GO

/****** Object:  Table [dbo].[SubjectScore]    Script Date: 2017/7/20 13:26:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SubjectScore](
	[Name] [nvarchar](100) NOT NULL,
	[SubjectName] [nvarchar](50) NOT NULL,
	[Score] [decimal](18, 0) NOT NULL
) ON [PRIMARY]

GO



go
--��ת��
DECLARE @sql VARCHAR(8000)
-- Grade��������Ҫ��[ƴ������
--SELECT @sql= isnull(@sql+',','')+'['+Grade +']'
SELECT @sql= ISNULL(@sql+',','')+[SubjectName] FROM [dbo].[SubjectScore]
GROUP BY [SubjectName]    
--print @sql       
SET @sql='
              select * from [SubjectScore] 
               pivot
                (
                  max(Score) for SubjectName in ('+@sql+')
                )t
            '
--ScoreҪת������ֵ��SubjectNameҪת��������
exec(@sql)






USE [Demo]
GO

/****** Object:  Table [dbo].[StudentScore]    Script Date: 2017/7/20 13:25:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StudentScore](
	[Name] [nvarchar](100) NOT NULL,
	[����] [decimal](18, 0) NOT NULL,
	[��ѧ] [decimal](18, 0) NOT NULL,
	[Ӣ��] [decimal](18, 0) NOT NULL
) ON [PRIMARY]

GO

go
 --��ת��
DECLARE @sql NVARCHAR(4000)
SELECT  @sql = ISNULL(@sql + ',', '') + QUOTENAME(name)
FROM    syscolumns
WHERE   id = OBJECT_ID('StudentScore')
        AND name NOT IN ( 'name' )
ORDER BY colid

SET @sql = '
           select name,[subjectName],[score] from StudentScore
             unpivot 
                   (
                     [Score] for [SubjectName] in (' + @sql + ')
                   )t
          '
--Scoreԭ�е�ֵ��SubjectNameԭ����
EXEC(@sql)

--ע��Ҫ�ӱ���t
  select name,[subjectName],[score] from StudentScore
             unpivot 
                   (
                     [Score] for [SubjectName] in  
                                                 (
                                                   ����,��ѧ,Ӣ��
                                                  )
                   )t
go
        --SELECT  Id, Amount , [Day]   FROM [Meters].[dbo].[MeterDailyRecords]
        --            UNPIVOT 
        --            (
        --                Amount FOR [Day] IN
        --                (
        --                  [Consumption01],[Consumption02],[Consumption03],
        --                  [Consumption04],[Consumption05],[Consumption06],
        --                  [Consumption07],[Consumption08],[Consumption09],
        --                  [Consumption10],[Consumption11],[Consumption12],
        --                  [Consumption13],[Consumption14],[Consumption15],
        --                  [Consumption16],[Consumption17],[Consumption18],
        --                  [Consumption19],[Consumption20],[Consumption21],
        --                  [Consumption22],[Consumption23],[Consumption24],
        --                  [Consumption25],[Consumption26],[Consumption27],
        --                  [Consumption28],[Consumption29],[Consumption30],
        --                  [Consumption31]
        --                 )
        --             )t

