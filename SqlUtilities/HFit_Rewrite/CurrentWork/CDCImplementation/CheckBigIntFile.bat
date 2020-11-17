echo off
if not exist %1 goto ERR
    copy /B /Y @IVP.BigInt_Build.sql + spacer.txt
    echo --------------------------------------------------------------- >> @IVP.BigInt_Build.sql
    echo -- PROCESSING SCRIPT FILE: %1 \n >> @IVP.BigInt_Build.sql
    echo --------------------------------------------------------------- >> @IVP.BigInt_Build.sql
    copy /B /Y @IVP.BigInt_Build.sql + %1
goto OVER
:ERR
echo -- FATAL ERROR : FILE MISSING %1 \n >> @IVP.BigInt_Build.sql
echo FATAL ERROR : FILE MISSING %1     >> @ERROR_MART.TXT
ECHO FATAL ERROR : FILE MISSING %1    
pause
:OVER