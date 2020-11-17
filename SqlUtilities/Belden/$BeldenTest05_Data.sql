select dbo.nNetBillingAmt('STDMWP', 5628152, 20100104)
select dbo.nNetBillingAmt('BPCSRI', 4643593, 20101003)
select dbo.nNetBillingAmt('STDWP', 551181, 20101006)
select dbo.nNetBillingAmt('STDWP', 1494087, 20100101)

select * from global_bi_v2 where invoice_nbr = '0001494087'