/****** Script for SelectTopNRows command from SSMS  ******/
SELECT A.word, A.ss_type, B.word, B.ss_type
FROM     wn_synset A, wn_synset B, wn_attr_adj_noun
where
wn_attr_adj_noun.synset_id_1 = A.synset_id 
AND wn_attr_adj_noun.synset_id_2 = B.synset_id
and A.word = 'catapult'

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
