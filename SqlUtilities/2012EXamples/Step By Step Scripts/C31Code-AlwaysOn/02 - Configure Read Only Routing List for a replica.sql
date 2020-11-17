/*
The following query configures each replicas read only routing list.  In the following query replace the SERVER NAME in both places with your server name.
*/
ALTER AVAILABILITY GROUP [SBSAGroup]
MODIFY REPLICA ON
N'<SERVER NAME>' WITH
(PRIMARY_ROLE (READ_ONLY_ROUTING_LIST=('<SERVER NAME>',' <SERVER NAME>', '<SERVER NAME>')));