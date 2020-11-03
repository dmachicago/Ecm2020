Exec sp_fulltext_service 'ft_timeout', 600000; -- ten minutes 
Exec sp_fulltext_service 'ism_size',@value=16;-- the max 