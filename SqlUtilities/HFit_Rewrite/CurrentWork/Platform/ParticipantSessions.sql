
use LFLCOACH
go

select p.FirstName, p.LastName,
p.ParticipantGUID, a.AcctID,s.sessionid,  c.CommunicationDate AS SessionDate 
from  Participant p
inner join accounts a on a.AccountID=p.AccountID
inner join coachpartxref cp on cp.ParticipantID=p.ParticipantID
inner join coachparticipantsessions s on s.coachpartxrefid=cp.coachpartxrefid
inner join Communications c on c.CommunicationID=s.CommunicationID
where a.IsPlatformAccount=1 and a.AcctID='trstmark'
and
p.ParticipantGUID  in ('5C65BE22-901C-4818-858F-0A497E9D1E64','1FBA8B9D-FFF5-4699-B58E-3497D0554656')

