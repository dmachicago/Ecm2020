UPDATE
    im
SET
    mf_item_number = gm.SKU --etc
FROM
    item_master im
    JOIN
    group_master gm ON im.sku=gm.sku 
    JOIN
    Manufacturer_Master mm ON gm.ManufacturerID=mm.ManufacturerID
WHERE
    im.mf_item_number like 'STA%'
    AND
    gm.manufacturerID=34
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
