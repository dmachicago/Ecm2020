CREATE TABLE [dbo].[Important_Data](
   [T_ID] [int] IDENTITY(1,1) NOT NULL,
   [T_Desc] [nchar](40) NOT NULL,
   [T_Back] [datetime] NULL,
   [T_Square] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
