--SVR2016 | AW_VMWARE | sa | Junebug1
declare @svr nvarchar(150) = 'dfin.database.windows.net,1433'
declare @uid nvarchar(50) = 'wmiller';
declare @pwd nvarchar(50) = 'Junebug1';
SELECT @svr +'|' + name + '|' + @uid + '|' + @pwd FROM sys.databases ;  



dfin.database.windows.net,1433|master|wmiller|Junebug1
dfin.database.windows.net,1433|AZ2016|wmiller|Junebug1
dfin.database.windows.net,1433|TestAzureDB|wmiller|Junebug1