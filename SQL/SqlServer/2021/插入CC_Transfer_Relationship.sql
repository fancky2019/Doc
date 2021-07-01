
--select  *  from  [NewClassesAdmin].[dbo].[CC_Transfer_Relationship];
-- 检查表是否存在
if exists (select * from sysobjects where id = object_id(N'[CC_Transfer_Relationship]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
--print('cunzai');
Drop TABLE [NewClassesAdmin].[dbo].[CC_Transfer_Relationship];
-- truncate table  [NewClassesAdmin].[dbo].[CC_Transfer_Relationship];
end

USE [NewClassesAdmin]
GO

/****** Object:  Table [dbo].[CC_Transfer_Relationship]    Script Date: 2021/6/30 17:18:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CC_Transfer_Relationship](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[JuniorSaleId] [nchar](50) NOT NULL,
	[JuniorSaleGuid] [uniqueidentifier] NULL,
	[SeniorSaleId] [nchar](50) NOT NULL,
	[SeniorSaleGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_CC_Transfer_Relationship] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO




















INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'bixx2' , 'bixx1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'chenjun2' , 'chenjun8')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'chenrz1' , 'chenrz')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'chentt1' , 'chentt')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'cheny4' , 'chenyu')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'chzhwlzy' , 'gaozhwlzy')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'czlz1' , 'gzlz1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'czlz11' , 'gzlz11')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'czmdhs' , 'gzmdhs')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'czwx' , 'liang1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'dengsch1' , 'dengsch')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'dingyy2' , 'dingyy1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'fengzhb1' , 'fengzhb')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'gaoy4' , 'gaoy3')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'guoqq1' , 'guoqq2')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'guzhh2' , 'guzhh')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'hem1' , 'hem')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'huangyy-kfc' , 'huangyy-kfg')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'huwh1' , 'huwh')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'huxr' , 'huxiaor')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'jinlj4' , 'jinlj1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'jianglw1' , 'jianglw')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'jiangml' , 'jiangml1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'jil-kfc' , 'jil-kfg')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'jinj1' , 'jinj')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'jinshq1' , 'jinshq')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'kuangj1' , 'kuangj')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'liang4' , 'liang3')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'lijp2' , 'lijp')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'lingyy2' , 'lingyy')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'liuff-kc' , 'liuff-kg')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'liuhl' , 'liuhl1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'liujx1' , 'liujx')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'liush1' , 'liush2')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'lixy4' , 'lixy3')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'maln2' , 'maln1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'maxy' , 'maxy1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'qimm1' , 'qimm')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'sheny-kc' , 'sheny-kg')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'shimj1' , 'shimj')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'tangchh1' , 'tangchh')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'tanghy1' , 'tanghy')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'wangjm' , 'wangjm1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'wanglh2' , 'wanglh1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'wangsh2' , 'wangsh')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'wangt1' , 'wangt')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'wangxj-kc' , 'wangxj-kg')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'wangyr-kc' , 'wangyr-kg')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'wuwd3' , 'wuwd2')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'xiangjun3' , 'xiangjun1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'xiangy2' , 'xiangy')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'xiay2' , 'xiay3')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'xuh3' , 'xuh2')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'xuhxq' , 'xuhxq1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'xusy1' , 'xusy2')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'yangpxq' , 'yangpxq1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'yangsj1' , 'yangsj')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'yangxj1' , 'yangxj')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'yupsh1' , 'yupsh')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'yuwn-kfc' , 'yuwn-kfg')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhaixb' , 'zhaixb1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhangjy1' , 'zhangjy')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhangl6' , 'zhangl5')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhangm-kc' , 'zhangm-kg')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhangxsh1' , 'zhangxsh2')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhangxy4' , 'zhangxy3')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhaoqs2' , 'zhaoqs')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhaoyl1' , 'zhaoyl')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhaoyq5' , 'zhaoyq4')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhilifang2' , 'zhilifang1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhongxuesheng2' , 'zhongxuesheng1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhoujj1' , 'zhoujj')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhouwsh1' , 'zhouwsh')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhouyy2' , 'zhouyy1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhuch1' , 'zhuch')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'liy8' , 'gzmdhs')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'fanshsh' , 'fanshsh1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'lix2' , 'lix3')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'rentt' , 'rentt1')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'liuxw1' , 'liuxw2')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'zhangy10' , 'zhangy11')
 

INSERT INTO [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]
           ([JuniorSaleId],[SeniorSaleId])
     VALUES ( 'sunl' , 'sunl1')
 








 --声明列
declare @ID int;
declare @JuniorSaleId nvarchar(50);
declare @JuniorSaleGuid  uniqueidentifier;
declare @SeniorSaleId nvarchar(50);
declare @SeniorSaleGuid  uniqueidentifier;
--声明游标
declare CC_Transfer_Relationship_Cursor cursor
for  SELECT ID,[JuniorSaleId] ,[JuniorSaleGuid],[SeniorSaleId] ,[SeniorSaleGuid]
     FROM [NewClassesAdmin].[dbo].[CC_Transfer_Relationship]

open CC_Transfer_Relationship_Cursor
--从游标里先读取
 FETCH NEXT FROM CC_Transfer_Relationship_Cursor INTO @ID, @JuniorSaleId,@JuniorSaleGuid,@SeniorSaleId,@SeniorSaleGuid
  WHILE (@@FETCH_STATUS = 0)--判断是否读取完
  begin
   select @JuniorSaleGuid= SysUserGuid  from [NewClassesAdmin].[dbo].[SysUser] where AdminUserId=@JuniorSaleId;
   select @SeniorSaleGuid= SysUserGuid  from [NewClassesAdmin].[dbo].[SysUser] where AdminUserId=@SeniorSaleId;
   update [NewClassesAdmin].[dbo].[CC_Transfer_Relationship] set [JuniorSaleGuid]=@JuniorSaleGuid, SeniorSaleGuid=@SeniorSaleGuid where ID=@ID;
     --从游标里继续读取
   FETCH NEXT FROM CC_Transfer_Relationship_Cursor INTO @ID, @JuniorSaleId,@JuniorSaleGuid,@SeniorSaleId,@SeniorSaleGuid
  end   

close  CC_Transfer_Relationship_Cursor
--释放游标
DEALLOCATE CC_Transfer_Relationship_Cursor








