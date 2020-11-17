
declare @Chg_Ver as int = null;
DECLARE @Commit_Time datetime = (SELECT TOP 1
                                            tc.commit_time
                                            FROM
                                                CHANGETABLE (CHANGES CMS_User, @Chg_Ver) c
                                                    JOIN sys.dm_tran_commit_table AS tc
                                                        ON c.sys_change_version = tc.commit_ts);
print @Commit_Time ;