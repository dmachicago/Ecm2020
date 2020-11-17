
echo off
cd\
cd C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation

rem call _CkFileExists "@IVP.BigInt_Build.sql"
del @IVP.BigInt_Build.sql

copy spacer.txt @IVP.BigInt_Build.sql

call CheckBigIntFile PrintImmediate.sql

call CheckBigIntFile ScriptAllForeignKeyConstraints_ReGenerateMissing.sql
call CheckBigIntFile proc_BigIntViewRebuild.sql
call CheckBigIntFile PrintImmediate.sql
call CheckBigIntFile DropAllForeignKeyCONSTRAINTS.sql

call CheckBigIntFile proc_TableDefaultConstraintExists.sql

call CheckBigIntFile proc_TableFKeysDrop.sql
call CheckBigIntFile proc_AddMissingTableFKeys.sql
call CheckBigIntFile proc_AllTblConstraintsDrop.sql
call CheckBigIntFile proc_AllTblConstraintsReGen.sql

call CheckBigIntFile proc_GetTableForeignKeys.sql


call CheckBigIntFile proc_ConvertBigintToInt.sql
call CheckBigIntFile proc_MasterBigintToInt.sql



