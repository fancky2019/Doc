USE [Demo]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2020/12/21 14:28:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[StockID] [int] NULL,
	[BarCodeID] [int] NULL,
	[SkuID] [int] NULL,
	[ProductName] [nvarchar](500) NOT NULL,
	[ProductStyle] [nvarchar](500) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[Status] [smallint] NOT NULL,
	[Count] [int] NOT NULL,
	[ModifyTime] [datetime] NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [GUID], [StockID], [BarCodeID], [SkuID], [ProductName], [ProductStyle], [Price], [CreateTime], [Status], [Count], [ModifyTime]) VALUES (1, N'23919da1-de7f-49f0-912d-d4e06a212caa', NULL, NULL, 0, N'ProductName', N'ProductStyle', CAST(57.21 AS Decimal(18, 2)), CAST(N'2020-12-21T14:25:23.720' AS DateTime), 1, 1000, CAST(N'2020-12-21T14:25:23.720' AS DateTime))
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
