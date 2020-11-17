
update KenticoCMS_1.dbo.HFit_HealthAssesmentUserAnswers set CodeName = Upper(codename) where CodeName = 'SeldomOrNever'
update KenticoCMS_2.dbo.HFit_HealthAssesmentUserAnswers set CodeName = Upper(codename) where CodeName = 'SeldomOrNever'
update KenticoCMS_3.dbo.HFit_HealthAssesmentUserAnswers set CodeName = Upper(codename) where CodeName = 'SeldomOrNever'

select * from BASE_HFit_HealthAssesmentUserAnswers where CodeName = 'SeldomOrNever'

update KenticoCMS_1.dbo.HFit_HealthAssesmentUserAnswers set CodeName = 'SeldomOrNever' where CodeName = 'SeldomOrNever'
update KenticoCMS_2.dbo.HFit_HealthAssesmentUserAnswers set CodeName = 'SeldomOrNever' where CodeName = 'SeldomOrNever'
update KenticoCMS_3.dbo.HFit_HealthAssesmentUserAnswers set CodeName = 'SeldomOrNever' where CodeName = 'SeldomOrNever'
