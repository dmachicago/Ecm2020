select top 10 
	  [SRC_SYS_ID]
      ,[DIVISION_GRP]
      ,[BUSINESSUNIT_GRP]
      ,[SRC_SYS_ID_POS]
      ,[DISTRIBUTOR_NAME]
      ,[MANUFACTURER_NAME]
      ,[REPORT_ENDING_DATE]
      ,[BRANCH_ID]
      ,[ANIXTER_REGION]
      ,[ANIXTER_DIVISION]
      ,[ITEM_NBR]
      ,[ITEM_DISTRIBUTOR]
      ,[AMERICAS_SALESINCENTIVE_RECAP_1]
      ,[AMERICAS_SALESINCENTIVE_RECAP_2]
      ,[SALES_EXTENDED_AMT_USD]
      ,[SALES_QUANTITY]
      ,[REPORT_ENDING_FISCAL_YEAR]
      ,[REPORT_ENDING_FISCAL_QUARTER]
      ,[REPORT_ENDING_FISCAL_PERIOD]
      ,[REPORT_ENDING_PERIOD_FISCAL_NAME]
      ,[REPORT_ENDING_CALENDAR_YEAR]
      ,[REPORT_ENDING_CALENDAR_QUARTER]
      ,[REPORT_ENDING_CALENDAR_MONTH]
      ,[REPORT_ENDING_CALENDAR_MONTH_NAME]
      ,[Current_Month_Sales_Extended_Amount]
      ,[Year_To_Date_Extended_Sales_Amount]
      ,[Previous_Year_To_date_Sales_Amount]
      ,[Sales_Extended_Amount_YoY_Change]
      ,[Current_Month_Quantity]
      ,[Year_To_Date_Extended_Quantity]
      ,[Previous_Year_To_date_Quantity]
      ,[Sales_Quantity_YoY_Change]
  FROM [SMART].[dbo].[GLOBAL_POS_V2]
 
where 
(Src_Sys_Id = 'BPCSCO' or Src_Sys_Id = 'BPCSRI')
and
Src_Sys_Id_Pos = 'AXT_V2'
and
Branch_ID in 
(
'010',
'051',
'097',
'101',
'102',
'104',
'105',
'106',
'107',
'108',
'111',
'112',
'114',
'115',
'117',
'119',
'122',
'123',
'125',
'135',
'141',
'143',
'144',
'145',
'147',
'148',
'152',
'153',
'173',
'175',
'176',
'178',
'179',
'182',
'184',
'185',
'186',
'187',
'189',
'190',
'193',
'194',
'198',
'221',
'223',
'227',
'229',
'235',
'266',
'277',
'281',
'286',
'288',
'296',
'297',
'298',
'307',
'318',
'330',
'333',
'349',
'364',
'379',
'380',
'386',
'387',
'431',
'460',
'461',
'468',
'506',
'508',
'509',
'512',
'513',
'516',
'518',
'519',
'523',
'524',
'531',
'532',
'549',
'551',
'552',
'554',
'563',
'601',
'602',
'605',
'607',
'610',
'612',
'613',
'615',
'621',
'655',
'661',
'665',
'666',
'669',
'670',
'671',
'672',
'673',
'674',
'687',
'690',
'802',
'806',
'002',
'006',
'008',
'011',
'049',
'052',
'098',
'195',
'174',
'237',
'273',
'275',
'293',
'6',
'622',
'637',
'8',
'847',
'848',
'849',
'850',
'851',
'852',
'853',
'854',
'855',
'856',
'857',
'859',
'860',
'861',
'862',
'863',
'865',
'866',
'871',
'872',
'873',
'874',
'875',
'876',
'881',
'882',
'883',
'884',
'885',
'886',
'887',
'890',
'891',
'892',
'893',
'894'
)


select dbo.nCurrentMoSalesAmtOrQty('2010', '10',dbo.nSalesExtendedAmtUsd('ANIXTER-CH',100,1.2)) 



select [dbo].[nSpecificYearToDateSalesAmtOrQty] ('2010' , '10', 1000,'10', '10', '2010')
select dbo.sReportEndingCalendarYear ('AXT_V2', '09',  '00')



select dbo.sReportEndingCalendarYear ('AXT_V3', '2010',  '2009')
select dbo.nSalesExtendedAmtUsd('ANIXTER-CH',100,1.2)
select [dbo].[nSpecificYearToDateSalesAmtOrQty] ('2010' , dbo.sCurrentPeriod(), 1000, '01', '10', '2010')

select dbo.nYearToDateExtendedSalesAmtOrQty(
			dbo.sConvertDate2Date4 ( dbo.sReportEndingCalendarYear ('AXT_V2', '10', '00') ), 
			dbo.nSalesExtendedAmtUsd('ANIXTER-CH',100,1.2))
			
select dbo.sReportEndingCalendarYear ('AXT_V2', '10', '00')			
select dbo.nYearToDateExtendedSalesAmtOrQty('2010', 1000)			
select dbo.nYearToDateExtendedSalesAmtOrQty('10', 1000)
select dbo.nYearToDateExtendedSalesAmtOrQty(dbo.sConvertDate2Date4('10'), 1000)


dbo.nCurrentMoSalesAmtOrQty(
			dbo.sReportEndingCalendarYear(P.SRC_SYS_ID_POS,TRD1.YEAR,TRD.YEAR) , 
			dbo.sReportEndingcalendarMonth(P.SRC_SYS_ID_POS,TRD1.MONTH,TRD.MONTH), 
			P.QUANTITY) as Current_Month_Quantity