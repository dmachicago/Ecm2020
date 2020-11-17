echo off
if not exist %1 goto ERR
    copy /B /Y @IVP.HA.Pull.Build.sql + spacer.txt
    echo --------------------------------------------------------------- >> @IVP.HA.Pull.Build.sql
    echo -- PROCESSING SCRIPT FILE: %1 \n >> @IVP.HA.Pull.Build.sql
    echo --------------------------------------------------------------- >> @IVP.HA.Pull.Build.sql
    copy /B /Y @IVP.HA.Pull.Build.sql + %1
goto OVER
:ERR
echo -- FATAL ERROR : FILE MISSING %1 \n >> @IVP.HA.Pull.Build.sql
echo FATAL ERROR : FILE MISSING %1     >> @ERROR_MART.TXT
ECHO FATAL ERROR : FILE MISSING %1    
pause
:OVER