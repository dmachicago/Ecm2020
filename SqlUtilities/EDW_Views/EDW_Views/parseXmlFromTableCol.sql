/*It will find all rows where the /Event/Indicator/Name equals GDP and then it will 
display the <Announcement>/<Value> and <Announcement>/<Date> for those rows.*/

SELECT 
    EventID, EventTime,
    AnnouncementValue = t1.EventXML.value('(/Event/Announcement/Value)[1]', 'decimal(10,2)'),
    AnnouncementDate = t1.EventXML.value('(/Event/Announcement/Date)[1]', 'date')
FROM
    dbo.T1
WHERE
    t1.EventXML.exist('/Event/Indicator/Name[text() = "GDP"]') = 1  --  
  --  
GO 
print('***** FROM: parseXmlFromTableCol.sql'); 
GO 
