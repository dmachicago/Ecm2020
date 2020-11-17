--accountcd = clientcode from hfit_ppteligibility (since you are already bringing that in).  then you can join to hfit_account and cms_site to get the guid and id fields

select * from hfit_ppteligibility
order by ItemGuid 

SELECT TOP (100) C.UserID, C.UserGUID, P.MPI, P.ClientCode, C.FullName
FROM     CMS_User AS C LEFT OUTER JOIN
                  HFit_PPTEligibility AS P ON C.UserID = P.UserID
WHERE  (P.MPI IS NOT NULL)

select top 1000 * from hfit_ppteligibility where MPI is not null


--******************************************************************************************************************
--This gets the BP Reading and ties it back the client and who created the entry and who last modified the entry.
--******************************************************************************************************************
SELECT TOP (100) C.UserID, C.UserGUID, P.MPI, P.ClientCode, C.FullName, HFit_TrackerBloodPressure.ItemCreatedBy, HFit_TrackerBloodPressure.ItemModifiedBy, 
                  CMS_User.FullName AS Expr1, CMS_User_1.FullName AS Expr2
FROM     CMS_User RIGHT OUTER JOIN
                  HFit_TrackerBloodPressure ON CMS_User.UserID = HFit_TrackerBloodPressure.ItemCreatedBy LEFT OUTER JOIN
                  CMS_User AS CMS_User_1 ON HFit_TrackerBloodPressure.ItemModifiedBy = CMS_User_1.UserID LEFT OUTER JOIN
                  CMS_User AS C INNER JOIN
                  HFit_PPTEligibility AS P ON C.UserID = P.UserID ON HFit_TrackerBloodPressure.UserID = C.UserID
WHERE  (P.MPI IS NOT NULL)


  --  
  --  
GO 
print('***** FROM: HFit_UserIDandGUID.sql'); 
GO 
