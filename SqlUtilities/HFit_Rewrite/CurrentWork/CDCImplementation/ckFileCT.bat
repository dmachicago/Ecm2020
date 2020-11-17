echo off
if not exist %1 goto ERR
    copy /B /Y @IVP.ChangeTracking.sql + spacer.txt
    echo --------------------------------------------------------------- >> @IVP.ChangeTracking.sql
    echo -- PROCESSING SCRIPT FILE: %1 \n >> @IVP.ChangeTracking.sql
    echo --------------------------------------------------------------- >> @IVP.ChangeTracking.sql
    copy /B /Y @IVP.ChangeTracking.sql + %1    
goto OVER
:ERR
ECHO FATAL ERROR : FILE MISSING %1    
echo FATAL ERROR : FILE MISSING %1     >> @ERROR_CT.TXT
pause
:OVER