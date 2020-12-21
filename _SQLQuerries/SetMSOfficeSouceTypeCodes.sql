Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = 'Office Documents' order by ProfileName, SourceTypeCode
Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = 'Office Documents' order by SourceTypeCode

select * from LoadProfileItem
select * from AvailFileTypes
select * from SourceType

-- delete from SourceType where SourceTypeCode not like '%.%' ;
-- delete from AvailFileTypes where ExtCode not like '%.%' ;
-- RefSourceType1281
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.adts', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.csv', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.dbf', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.dif', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.docm', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.docx', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.dot', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.dotm', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.dotx', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.htm', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.html', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.mht', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.mhtml', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.ods', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.odt', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.pdf', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.prn', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.rtf', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.slk', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.txt', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.wps', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xla', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xlam', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xls', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xlsb', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xlsm', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xlsx', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xlt', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xltm', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xltx', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xlw', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xml', 'Office Documents');
GO
insert into [SourceType] (SourceTypeCode, SourceTypeDesc) values ('.xps', 'Office Documents');
GO

select * from SourceType where SOurceTypeCode = '.adts' ;
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.adts');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.csv');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.dbf');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.dif');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.docm');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.docx');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.dot');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.dotm');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.dotx');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.htm');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.html');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.mht');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.mhtml');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.ods');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.odt');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.pdf');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.prn');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.rtf');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.slk');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.txt');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.wps');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xla');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xlam');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xls');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xlsb');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xlsm');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xlsx');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xlt');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xltm');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xltx');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xlw');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xml');
GO
insert into [LoadProfileItem] (ProfileName, SourceTypeCode) values ('Office Documents', '.xps');
GO

