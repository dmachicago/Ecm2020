cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork"

del IVP.RELEASE.X.X.sql 

copy spacer.txt IVP.RELEASE.X.X.sql


copy /A /Y IVP.RELEASE.X.X.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails_BadDates.sql"

copy /A /Y IVP.RELEASE.X.X.sql + spacer.txt
copy /A /Y IVP.RELEASE.X.X.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails.sql"

rem **************************************************************************************************
copy /A /Y IVP.RELEASE.X.X.sql + TheEnd.sql
