
echo off

cd "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation"
dir  


if exist %1 (
    rem echo file exists
) else (
    echo "MISSING: "  %1
)
pause