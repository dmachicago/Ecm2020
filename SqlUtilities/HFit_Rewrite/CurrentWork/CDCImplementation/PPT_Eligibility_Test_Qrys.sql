select top 1000 * from STAGING_HFIT_PPTEligibility_Audit order by PPTID, SYS_CHANGE_VERSION
select top 1000 * from STAGING_HFIT_PPTEligibility_Update_History order by PPTID, SYS_CHANGE_VERSION
select top 1000 * from STAGING_HFIT_PPTEligibility 

SELECT
	*
	FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, 160) AS CT
 order by PPTID, SYS_CHANGE_VERSION

-- truncate table STAGING_HFIT_PPTEligibility_Audit

--You can view the current version of a particular row by using the VERSION command within the CHANGETABLE function as follows:

SELECT * FROM CHANGETABLE(VERSION HFIT_PPTEligibility, (PPTID), (7752) ) AS CT