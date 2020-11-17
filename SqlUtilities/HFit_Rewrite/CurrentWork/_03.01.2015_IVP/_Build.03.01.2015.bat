cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_03.01.2015_IVP"
dir  

del IVP.03.01.2015.sql

copy "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt" IVP.03.01.2015.sql
rem pause

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_SmallStepResponses.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserDetail.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardsDefinition.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_TrackerCompositeDetails.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\View_EDW_RewardProgram_Joined.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardTriggerParameters.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardUserLevel.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\view_EDW_RewardAwardDetail.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\Proc_EDW_TrackerMetadataExtract.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\HFit_LKP_GoalCloseReason_Create_Table.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CreateTracker_EDW_Metadata.sql"

copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\proc_GetViewBaseTables.sql"

rem **********************************************************************************************************************************
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\spacer.txt"
copy /B /Y IVP.03.01.2015.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\IVP_Views.sql"

