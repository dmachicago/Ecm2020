select FullTextCatalogProperty('ftCatalog', 'IndexSize')
select FullTextCatalogProperty('ftCatalog', 'ItemCount')
select case FullTextCatalogProperty('ftCatalog', 'PopulateStatus')
          when 0 then 'Idle'
          when 1 then 'Full population in progress'
          when 2 then 'Paused'
          when 3 then 'Throttled'
          when 4 then 'Recovering' 
          when 5 then 'Shutdown'
          when 6 then 'Incremental population in progress'
          when 7 then 'Building index'
          when 8 then 'Disk is full. Paused.'
          when 9 then 'Change tracking'
          else 'Error reading FullTextCatalogProperty PopulateStatus'
        end

select FullTextCatalogProperty('ftEmailCatalog', 'IndexSize')
select FullTextCatalogProperty('ftEmailCatalog', 'ItemCount')
select case FullTextCatalogProperty('ftEmailCatalog', 'PopulateStatus')
          when 0 then 'Idle'
          when 1 then 'Full population in progress'
          when 2 then 'Paused'
          when 3 then 'Throttled'
          when 4 then 'Recovering' 
          when 5 then 'Shutdown'
          when 6 then 'Incremental population in progress'
          when 7 then 'Building index'
          when 8 then 'Disk is full. Paused.'
          when 9 then 'Change tracking'
          else 'Error reading FullTextCatalogProperty PopulateStatus'
        end