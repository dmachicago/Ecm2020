
GO
DECLARE @Xml XML

SELECT @Xml = '<admin submitter_id="login0" effective_date="mm/dd/yyyy"> 
<rec effected_id="login1" adjustment="100.00" type="foo"> 
<reason reason_id="1" /> 
<reason reason_id="2" /> 
</rec> 
<rec effected_id="login2" adjustment="50.00" type="bar"> 
<reason reason_id="3" /> 
</rec> 
</admin>'

SELECT
    Submitter = @xml.value('(/admin/@submitter_id)[1]', 'varchar(50)'),
    EffectedID = Rec.value('(@effected_id)[1]', 'varchar(50)'),
    DateStamp = @xml.value('(/admin/@effective_date)[1]', 'varchar(50)'),
    TypeID = Rec.value('(@type)[1]', 'varchar(50)'),
    ReasonID = Reason.value('(@reason_id)[1]', 'int')
FROM
    @xml.nodes('/admin/rec') AS Tbl(Rec)
CROSS APPLY
    Rec.nodes('reason') AS T2(Reason)  --  
  --  
GO 
print('***** FROM: XmlParseToTable.sql'); 
GO 
