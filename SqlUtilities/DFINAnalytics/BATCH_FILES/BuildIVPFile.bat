type echo '-- PROCESSING: ' %1
type %1 >> D:\dev\SQL\DFINAnalytics\Batch_Files\IVP_DFINAnalytics.sql
call AddSeparator.bat %2
