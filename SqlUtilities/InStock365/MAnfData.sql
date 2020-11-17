--Delete from ProductClass where ProductID = 'CS-32OZ-AM'

--Delete from Product where ProductID = 'CS-32OZ-AM'

SELECT        Rep.ManfID, Rep.ManfName, Rep.BusinessHours, Rep.TimeZone, Rep.SpecialInst, Rep.OfficePhone, Rep.OfficeFax, Rep.ContactName, Rep.ContactPhone, 
                         Rep.EmailAddress, Rep.RowNbr, Address.AdddressKey AS AdddressKey, Address.BusinessHours AS OpenHours, 
                         Address.TimeZone AS AddrTimeZone, Address.Country, Address.StreetAddr1, Address.StreetAddr2, Address.Suite, Address.City, Address.State, Address.Zip, 
                         Address.SpecialInst AS AddrInst, Address.OfficePhone AS AddrPhone, Address.OfficeFax AS AddrFax, Address.ContactName AS AddrContact, Address.ContactPhone AS AddrContactPhone, 
                         Address.AddrTypeCode
FROM            Address LEFT OUTER JOIN
                         ManfRepAddr AS RepAddr ON Address.AdddressKey = RepAddr.AdddressKey RIGHT OUTER JOIN
                         ManfRep AS Rep ON RepAddr.ManfID = Rep.ManfID



