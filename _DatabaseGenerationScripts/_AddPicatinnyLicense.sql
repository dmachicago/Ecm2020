
go

use [DMA.UD.License]
go

IF EXISTS (Select 1 from dbo.license where [CustomerName] = 'Picatinny Arsenal' and CustomerID = 'PA-001' )
begin
    update [dbo].[License] 
                     set [license] = '/yLziP/LNcFehAeU/fXw8GLn5NwmqsIPr0Ghm7sRLr1Rg/ALDUFb74SIy/reQmNLBvpYMoSL0tU5qFpu9O7YRloK2oA6NKGtPJ7KpCzWhiRVrfXwzAXgXEZAmVnu18ritq2w7SG9lLimvDdABGpck90VNMZUzpftkMA47Dwxzl3fEbBuWEaAta0ljovVMd0XQrgsjvCEaqUcGgPWkL8CENF1uQ2sUDaMXkPvziIHCxk8GDUoL6oQjKCZFZQm8lgAzz6LKaXZNu15gHRk56cv0/MYZrQglUofcjD/tTMFs1uu5ckCxhQsP8JBFWFT9fRjeVB0K/SXYiHu7k+eUOLqR3AkDgH214Ipc7OCRj5Jq0vdjomXnEnYc6B46oPV4pReg8Sij13fizE7/8aC5vedqicrKXR6V6QSM69maHW1w2/mVnPk2R2A/f8xdfLNN6EOg59gVMbYtTDE7YXFYkIyD/L+enE+uTt1meY1vr6wLNgdA6fTA2ewRwOUcqJwYI0vH2+wbvxTUdzB3OQmas7PybTb+poN0g1dEMeHqwWIVMNCTLrwzjO6K8tc+utfOL5fYRIq+aKbLybjrhbQj8bHMB9p+60s+RZCj8p2HzKdP9jGPZ0pmidE0Z0m3Qoe6qk1yvomy/G0pzlCoFvAaRTgNanD5zFMdXnwES+n01t1SxhWck4Ovw8sQLnaUBYH3wHOioShK7SWzWoRU+UqlqIGGDVuSdI6nbd2YHVBuLYRg2AYcgXqnUprhI+ifPh1LeewvFoUTTAwqcJ5/AIDEfvHsoJyzq7Nz1ju06Ed5fmqtZ4qriOu7NgrGWHqhPD8ZU96v1DJXrNZ0tdZzcIjYUa4rHV/3QfDfaB0Anh33tZJC3mIXNAQhQoSg4SIy/reQmNLBvpYMoSL0tWoGJduDZpQuLkZNtRGi9AYClWjXuFmj1RKEFsPDQ0Gp4Ij2+NoHzYCT1I50dzTQwI=' 
                      where [CustomerName] = 'Picatinny Arsenal' and CustomerID = 'PA-001' 
END
ELSE
BEGIN
 INSERT INTO License(CustomerName,CustomerID,LicenseExpireDate,NbrSeats,NbrSimlUsers,CompanyResetID,MasterPW,LicenseGenDate,License,LicenseID,ContactName,ContactEmail,ContactPhoneNbr,CompanyStreetAddress,CompanyCity,CompanyState,CompanyZip,MaintExpireDate,CompanyCountry, LicenseTypeCode, ckSdk, MaxClients, ServerName, SqlInstanceName) values ('Picatinny Arsenal','PA-001','1/31/2050 12:00:00 AM',1000,1000,'ECMLIBRARY-2020-001','wdmsdm','10/31/2019 9:47:14 AM','/yLziP/LNcFehAeU/fXw8GLn5NwmqsIPr0Ghm7sRLr1Rg/ALDUFb74SIy/reQmNLBvpYMoSL0tU5qFpu9O7YRloK2oA6NKGtPJ7KpCzWhiRVrfXwzAXgXEZAmVnu18ritq2w7SG9lLimvDdABGpck90VNMZUzpftkMA47Dwxzl3fEbBuWEaAta0ljovVMd0XQrgsjvCEaqUcGgPWkL8CENF1uQ2sUDaMXkPvziIHCxk8GDUoL6oQjKCZFZQm8lgAzz6LKaXZNu15gHRk56cv0/MYZrQglUofcjD/tTMFs1uu5ckCxhQsP8JBFWFT9fRjeVB0K/SXYiHu7k+eUOLqR3AkDgH214Ipc7OCRj5Jq0vdjomXnEnYc6B46oPV4pReg8Sij13fizE7/8aC5vedqicrKXR6V6QSM69maHW1w2/mVnPk2R2A/f8xdfLNN6EOg59gVMbYtTDE7YXFYkIyD/L+enE+uTt1meY1vr6wLNgdA6fTA2ewRwOUcqJwYI0vH2+wbvxTUdzB3OQmas7PybTb+poN0g1dEMeHqwWIVMNCTLrwzjO6K8tc+utfOL5fYRIq+aKbLybjrhbQj8bHMB9p+60s+RZCj8p2HzKdP9jGPZ0pmidE0Z0m3Qoe6qk1yvomy/G0pzlCoFvAaRTgNanD5zFMdXnwES+n01t1SxhWck4Ovw8sQLnaUBYH3wHOioShK7SWzWoRU+UqlqIGGDVuSdI6nbd2YHVBuLYRg2AYcgXqnUprhI+ifPh1LeewvFoUTTAwqcJ5/AIDEfvHsoJyzq7Nz1ju06Ed5fmqtZ4qriOu7NgrGWHqhPD8ZU96v1DJXrNZ0tdZzcIjYUa4rHV/3QfDfaB0Anh33tZJC3mIXNAQhQoSg4SIy/reQmNLBvpYMoSL0tWoGJduDZpQuLkZNtRGi9AYClWjXuFmj1RKEFsPDQ0Gp4Ij2+NoHzYCT1I50dzTQwI=',1,'W. Dale Miller','wdalemiller@gmail.com','847.274.6622','US Army Ardec
Building 31, Room 32
Picatinny Arsenal, NJ 07806','Picatinny Arsenal','NJ','07806','1/31/2050 12:00:00 AM','USA','Roaming',1,0,'T310','')
END

go
