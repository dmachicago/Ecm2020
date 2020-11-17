cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork"

del IVP.RELEASE.3.5.sql 

copy spacer.txt IVP.RELEASE.3.5.sql


copy /A /Y IVP.RELEASE.3.5.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\view_EDW_RewardsDefinition.sql"

copy /A /Y IVP.RELEASE.3.5.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.5.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail.sql"

copy /A /Y IVP.RELEASE.3.5.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.5.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_BioMetrics.sql"

copy /A /Y IVP.RELEASE.3.5.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.5.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentClientView.sql"

copy /A /Y IVP.RELEASE.3.5.sql + spacer.txt
copy /A /Y IVP.RELEASE.3.5.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_HealthAssesmentDeffinition.sql"

rem **************************************************************************************************
copy /A /Y IVP.RELEASE.3.5.sql + TheEnd.sql
