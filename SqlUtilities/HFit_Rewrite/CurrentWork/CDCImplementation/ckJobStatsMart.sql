
--create procedure ckJobStatsMart
--as
select * from JOB_RUN_TIMES 
where runid = '8B01BF33-F644-4E6A-97BE-7A6876520E8B'
Order by jobname, step_id, loop_cnt desc

select datediff(s,'2016-06-12 17:31:37.950','2016-06-12 17:38:40.720') 