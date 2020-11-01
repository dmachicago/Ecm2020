echo off
if not exist %1 goto ERR
    copy /B /Y @IVP_MasterBuild.sql + spacer.txt
    echo --------------------------------------------------------------- >> @IVP_MasterBuild.sql
    echo -- PROCESSING SCRIPT FILE: %1 >> @IVP_MasterBuild.sql
    echo --------------------------------------------------------------- >> @IVP_MasterBuild.sql
    rem copy /B /Y @IVP_MasterBuild.sql + %1
    
    TYPE %1 >> @IVP_MasterBuild.sql
    echo GO >> @IVP_MasterBuild.sql

goto OVER
:ERR
echo -- FATAL ERROR : FILE MISSING %1 \n >> @IVP_MasterBuild.sql
echo FATAL ERROR : FILE MISSING %1     >> @ERROR_MART.TXT
ECHO FATAL ERROR : FILE MISSING %1    
:OVER
