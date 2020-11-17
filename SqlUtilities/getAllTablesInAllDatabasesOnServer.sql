
sp_msForEachDb 'select "?" as db, * from [?].sys.tables ';
sp_msForEachDb 'select "?" as db, T.name, T.Object_ID from [?].sys.tables T ';
sp_msForEachDb 'select "?" as db, I.name as IDX, T.* from [?].sys.tables T join [?].sys.indexes I on T.object_id = I.object_id';