declare @CdAnswersTempTable as table (NPortSectionCDAnswersID bigint INDEX IX1 CLUSTERED) ;

insert into @CdAnswersTempTable (NPortSectionCDAnswersID)
	SELECT ans.NPortSectionCDAnswersID	
	FROM NPortSectionCDAnswers ans
	INNER JOIN FilingFund ff on ff.FilingFundID  = ans.FilingFundID
	INNER JOIN Fund fu ON fu.FundID = ff.FundID
	INNER JOIN Filing f ON f.FilingID = ff.FilingID
	INNER JOIN FundGroup fg ON fg.FundGroupID = fu.FundGroupID
	INNER JOIN Complex c ON c.ComplexID = fg.ComplexID
	WHERE CONTAINS(ans.*,@SearchText)
	--OR CONTAINS((MasterIdentifier,SecurityCusip,ISIN,Ticker),@InputSearchPhrase) -- currently not utilized
	AND f.AccountPeriodID = @AccountPeriodId
	AND c.ComplexID = @ComplexId
	AND fu.FundID = ISNULL(@FundId, fu.FundID)
	AND ans.SleeveCode = ISNULL(@SleeveCode, ans.SleeveCode)	;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
