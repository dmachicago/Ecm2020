
echo off

if not exist %1 goto ERR

rem ******************************
rem ELSE ADD THE FILE TO THE IVP
rem ******************************
copy /B /Y @IVP.Tracker_Build.sql + spacer.txt
echo --------------------------------------------------------------- >> @IVP.Tracker_Build.sql
echo -- PROCESSING SCRIPT FILE: %1 \n >> @IVP.Tracker_Build.sql
echo --------------------------------------------------------------- >> @IVP.Tracker_Build.sql
copy /B /Y @IVP.Tracker_Build.sql + %1
goto OVER

:ERR
echo -- FATAL ERROR : FILE MISSING %1 \n >> @IVP.Tracker_Build.sql
echo FATAL ERROR : FILE MISSING %1     >> @ERROR_MART.TXT
ECHO FATAL ERROR : FILE MISSING %1 written to file @ERROR_MART.TXT
pause
:OVER