echo off
if not exist %1 goto ERR
    copy /B /Y @IVP.MART_Build.sql + spacer.txt
    echo --------------------------------------------------------------- >> @IVP.MART_Build.sql
    echo -- PROCESSING SCRIPT FILE: %1 \n >> @IVP.MART_Build.sql
    echo --------------------------------------------------------------- >> @IVP.MART_Build.sql
    copy /B /Y @IVP.MART_Build.sql + %1
goto OVER
:ERR
echo -- FATAL ERROR : FILE MISSING %1 \n >> @IVP.MART_Build.sql
echo FATAL ERROR : FILE MISSING %1     >> @ERROR_MART.TXT
ECHO FATAL ERROR : FILE MISSING %1    
pause
:OVER