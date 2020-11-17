SELECT  j.name JobName
      , h.step_name StepName
	 , CASE h.run_status
          WHEN 0 THEN 'failed'
          WHEN 1 THEN 'Succeded'
          WHEN 2 THEN 'Retry'
          WHEN 3 THEN 'Cancelled'
          WHEN 4 THEN 'In Progress'
        END AS ExecutionStatus
      , CAST(STR(h.run_date, 8, 0) AS DATETIME)
        + CAST(STUFF(STUFF(RIGHT('000000' + CAST (h.run_time AS VARCHAR(6)), 6),
                           5, 0, ':'), 3, 0, ':') AS DATETIME) AS StartDatetime
      , DATEADD(SECOND,
                ( ( h.run_duration / 1000000 ) * 86400 )
                + ( ( ( h.run_duration - ( ( h.run_duration / 1000000 )
                                           * 1000000 ) ) / 10000 ) * 3600 )
                + ( ( ( h.run_duration - ( ( h.run_duration / 10000 ) * 10000 ) )
                      / 100 ) * 60 ) + ( h.run_duration - ( h.run_duration
                                                            / 100 ) * 100 ),
                CAST(STR(h.run_date, 8, 0) AS DATETIME)
                + CAST(STUFF(STUFF(RIGHT('000000'
                                         + CAST (h.run_time AS VARCHAR(6)), 6),
                                   5, 0, ':'), 3, 0, ':') AS DATETIME)) AS EndDatetime
      , STUFF(STUFF(REPLACE(STR(run_duration, 6, 0), ' ', '0'), 3, 0, ':'), 6,
              0, ':') AS run_duration_formatted
      , ( ( h.run_duration / 1000000 ) * 86400 ) + ( ( ( h.run_duration
                                                         - ( ( h.run_duration
                                                              / 1000000 )
                                                             * 1000000 ) )
                                                       / 10000 ) * 3600 )
        + ( ( ( h.run_duration - ( ( h.run_duration / 10000 ) * 10000 ) )
              / 100 ) * 60 ) + ( h.run_duration - ( h.run_duration / 100 )
                                 * 100 ) AS RunDurationInSeconds
      , h.message MessageGenerated
FROM    sysjobhistory h
        INNER JOIN sysjobs j
            ON j.job_id = h.job_id
ORDER BY j.name , h.run_date DESC
      , h.run_time desc
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
