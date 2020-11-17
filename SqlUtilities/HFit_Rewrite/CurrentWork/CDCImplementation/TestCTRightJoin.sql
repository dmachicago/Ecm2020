

select V.* from CHANGETABLE (CHANGES HFIT_HealthAssesmentUserAnswers , NULL) AS CT_HFIT_HealthAssesmentUserAnswers
    right join view_EDW_PullHAData as V on V.USERANSWERITEMID = CT_HFIT_HealthAssesmentUserAnswers.ItemID
                    