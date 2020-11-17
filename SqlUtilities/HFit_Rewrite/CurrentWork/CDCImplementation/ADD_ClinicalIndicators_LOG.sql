
create procedure ADD_ClinicalIndicators_LOG (@logentry nvarchar(4000))
as 
begin 
    insert into FTP_ClinicalIndicators_LOG (logentry) values (@logentry);
end 