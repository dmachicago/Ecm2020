select
    object_name(m.object_id) as OBJ, m.*
from
    sys.sql_modules m
where
    m.definition like N'%view_HFit_RewardLevel_Joined%'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
