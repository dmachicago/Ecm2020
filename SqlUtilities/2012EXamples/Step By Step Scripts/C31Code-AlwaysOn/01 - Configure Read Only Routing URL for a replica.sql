/*
use the below script to configure the URL routing for a given replica.  In the below query replace <SERVER NAME> with your server name and
replace the SERVER NAME.DOMAIN with your information
*/
USE master
GO
ALTER AVAILABILITY GROUP [SBSAGroup]
MODIFY REPLICA ON
N'<SERVER NAME>' WITH
(SECONDARY_ROLE (READ_ONLY_ROUTING_URL = N'TCP://SERVER NAME.DOMAIN.com:1433'));