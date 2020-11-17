SELECT 
'Server' + char(253) + @@SERVERNAME +  char(254) +
'Table' + char(253) + '2ph_diagnosis' +  char(254) +
'Diagnosis Code' + char(253) + [Diagnosis Code] +  char(254) +
'Diagnosis Code Version' +  CHAR(253) + [Diagnosis Code Version] + char(254) +
'Medical Record Number' + char(254) + [Medical Record Number] + char(254) +
'Patient ID' + char(255) + [Patient ID],
    [EcmGuid] 
FROM [2ph_diagnosis]