
CREATE VIEW view_UsersByPeriod
AS SELECT U.MemberShipID , 
          U.MemberShipUserID , 
          B.UserID , 
          B.UserCreated AS UserEnabledDate , 
          B.UserLastModified AS UserDisabledDate , 
          D.LASTMODIFIEDDATE , 
          B.UserEnabled AS BaseEnabledStatus , 
          D.UserEnabled AS DeltaEnabledStatus , 
          CASE D.UserEnabled
              WHEN 1
                  THEN 'ENABLED'
              WHEN 0
                  THEN 'DISABLED'
          END AS Status
     FROM
          BASE_CMS_user AS B
          JOIN BASE_CMS_user_DEL AS D
          ON B.SurrogateKey_cms_user = D.SurrogateKey_cms_user
         AND B.UserEnabled != D.UserEnabled
         AND B.UserEnabled = 1
         AND D.UserEnabled = 0
          JOIN BASE_CMS_MembershipUser AS U
          ON U.dbname = B.dbname
         AND U.UserID = B.UserID;  

GO

SELECT *
  FROM view_UsersByPeriod
  WHERE UserEnabledDate >= '2014-03-28'
    AND UserDisabledDate <= '2016-07-07';

SELECT *
  FROM view_UsersByPeriod
  WHERE UserEnabledDate BETWEEN '2016-07-07' AND '2016-07-11'
    AND Status = 'ENABLED';


GO



CREATE VIEW view_DisabledUsers
AS SELECT B.UserID , 
          B.UserCreated AS UserEnabledDate , 
          B.UserLastModified , 
          D.LASTMODIFIEDDATE AS UserDisabledDate , 
          B.UserEnabled , 
          D.UserEnabled
     FROM
          BASE_CMS_user AS B
          JOIN BASE_CMS_user_DEL AS D
          ON B.SurrogateKey_cms_user = D.SurrogateKey_cms_user
         AND B.UserEnabled != D.UserEnabled
         AND B.UserEnabled = 0
         AND D.UserEnabled = 1
     WHERE B.UserLastModified BETWEEN '2016-07-07' AND '2016-07-11';
GO

CREATE VIEW view_ReEnabledUsers
AS SELECT B.UserID , 
          B.UserCreated AS UserEnabledDate , 
          B.UserLastModified , 
          D.LASTMODIFIEDDATE AS UserDisabledDate , 
          B.UserEnabled , 
          D.UserEnabled
     FROM
          BASE_CMS_user AS B
          JOIN BASE_CMS_user_DEL AS D
          ON B.SurrogateKey_cms_user = D.SurrogateKey_cms_user
         AND B.UserEnabled != D.UserEnabled
         AND B.UserEnabled = 1
         AND D.UserEnabled = 0
     WHERE B.UserLastModified BETWEEN '2016-07-07' AND '2016-07-11';


