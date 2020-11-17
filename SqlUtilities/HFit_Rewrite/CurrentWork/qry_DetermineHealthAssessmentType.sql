
/*
07.09.2-15 - (wdm) Talked to Mark and he explained that in the main record for a PPT,
		  if the HADocumentConfigID is null then the SHORT HA is in effect,
		  and if it is not null, then there is a LONG assessment that has 
		  been completed. SO here is the QRY that gives that info back.
    NOTE: There may be an issue as it must use the ID as the GUID is not 
	   available. This would mean the possibility for the data to change
	   across server instances.
*/
select itemID,HADocumentConfigID, (case  
			 when HADocumentConfigID is null THEN 'SHORT_VER'
			 when HADocumentConfigID is not null THEN 'LONG_VER'
    else 'UNKNOWN'
    end) as HealthAssessmentType
from HFit_HealthAssesmentUserStarted