
GO
print ('FROM Create_HFit_LKP_TrackerVendor_Table.SQL') ;

if not exists (select name from sys.tables where name = 'HFit_LKP_TrackerVendor')
BEGIN
print ('Creating table [HFit_LKP_TrackerVendor]') ;
CREATE TABLE [dbo].[HFit_LKP_TrackerVendor](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[VendorName] [varchar](32) NOT NULL,
	[ItemCreatedBy] [int] NULL,
	[ItemCreatedWhen] [datetime2] (7)  NULL,
	[ItemModifiedBy] [int] NULL,
	[ItemModifiedWhen] [datetime2] (7)  NULL,
	[ItemOrder] [int] NULL,
	[ItemGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HFit_LKP_TrackerVendor] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] ;

ALTER TABLE [dbo].[HFit_LKP_TrackerVendor] ADD  CONSTRAINT [DEFAULT_HFit_LKP_TrackerVendor_ItemGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ItemGUID];

insert into HFit_LKP_TrackerVendor ([VendorName]) values ('crossover');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('meds');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('labcorp');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('quest_diag');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('staywell');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('walgreens_health');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('supervalu');

END
GO
--select * from HFit_LKP_TrackerVendor
print ('CREATED table [HFit_LKP_TrackerVendor]') ;
GO
