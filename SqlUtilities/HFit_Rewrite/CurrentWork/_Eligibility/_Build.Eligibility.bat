cls

cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility"
dir  

del IVP.Eligibility.sql



copy "spacer.txt" IVP.Eligibility.sql 

rem copy /A /Y IVP.Eligibility.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\Create_Tables_RoleEligibility.sql"
rem copy /A /Y IVP.Eligibility.sql  + spacer.txt

copy /A /Y IVP.Eligibility.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\proc_build_EDW_Eligibility.sql"

copy /A /Y IVP.Eligibility.sql  + spacer.txt
copy /A /Y IVP.Eligibility.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\EligibilityImplementationScript.sql"

copy /A /Y IVP.Eligibility.sql  + spacer.txt
copy /A /Y IVP.Eligibility.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\view_EDW_Eligibility.sql"

copy /A /Y IVP.Eligibility.sql  + spacer.txt
copy /A /Y IVP.Eligibility.sql + Create_Job_update_EDW_Eligibility.sql

copy /A /Y IVP.Eligibility.sql  + spacer.txt
copy /A /Y IVP.Eligibility.sql + proc_EDW_RoleEligibilityExpired.sql

copy /A /Y IVP.Eligibility.sql  + spacer.txt
copy /A /Y IVP.Eligibility.sql + proc_EDW_RoleEligibilityStarted.sql

copy /A /Y IVP.Eligibility.sql  + spacer.txt
copy /A /Y IVP.Eligibility.sql + proc_EDW_RoleEligibilityDaily.sql

copy /A /Y IVP.Eligibility.sql  + spacer.txt
copy /A /Y IVP.Eligibility.sql + Create_Job_update_EDW_RoleEligibility.sql

copy /A /Y IVP.Eligibility.sql  + spacer.txt
copy /A /Y IVP.Eligibility.sql + view_EDW_RoleEligibility.sql

rem copy /A /Y IVP.Eligibility.sql  + spacer.txt
rem copy /A /Y IVP.Eligibility.sql + LoadInitialRoleEligibilityData.sql

