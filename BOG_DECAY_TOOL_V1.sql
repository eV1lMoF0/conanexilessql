
CREATED BY =A15=Bog. Last modified 3/7.
Search the server browser for A15.
We are ranked #3 on topgameservers, #5 on gametracket, #11 on battlemetrics as of 3/7.
US PVP. No exploits, 1x raid on a target per day, 1 person stack limit, no racism, unradable bases allowed, .4 claim radius, 0 admin abuse.

-- DELETES DECAYED PLAYERS, GUILDS, ITEMS, BUILDINGS BASED ON THE BOG_TIME COLUMN ADDITION. DELETES EVERYTHING PRIOR TO 7 DAYS AGO FROM CURRENT DB TIME. DOES NOT DELETE PLAYERS IN GUILDS THAT AT LEAST A SINGLE MEMBER ACTIVE.
--lines are alternating, first for players without guilds, then guilds themselves
--Funcom added a lastTimeOnline column into the database but I haven't tested if it's working to update the modify timestamp at all even though the trigger is set for it,
--however the trigger also updates the modify timestamp for other reasons: (death, guild rank change, guild change, level change). So tell your players to either change
--one single guild members rank up then down, or have one member die. If you are a solo player you must satisfy one of the non-guild requirements unless you joing a guild.
--As soon as Funcom makes the lastTimeOnline field work properly, the trigger is already working to accomodate that.
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where bog_time < datetime('now','-7 days') and owner_id not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null)));
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where bog_time < datetime('now','-7 days') and owner_id not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where bog_time < datetime('now','-7 days') and owner_id not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null)));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select id from characters where bog_time < datetime('now','-7 days') and owner_id not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null)));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null)));
delete from buildings where owner_id in (select id from characters where bog_time < datetime('now','-7 days') and guild is null);
delete from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null));
delete from item_properties where owner_id in (select id from characters where bog_time < datetime('now','-7 days') and owner_id not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null));
delete from item_properties where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null));
delete from item_inventory where owner_id in (select id from characters where bog_time < datetime('now','-7 days') and owner_id not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null));
delete from item_inventory where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null));
delete from actor_position where id in (select id from characters where bog_time < datetime('now','-7 days') and guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null));
delete from actor_position where id in (select guildid from guilds where guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null));
delete from guilds where guildid not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null);
delete from character_stats where char_id in (select id from characters where bog_time < datetime('now','-7 days') and guild is null);
delete from character_stats where char_id in (select id from characters where bog_time < datetime('now','-7 days') and guild not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null));
delete from characters where id in (select id from characters where bog_time < datetime('now','-7 days') and guild is null);
delete from characters where id in (select id from characters where bog_time < datetime('now','-7 days') and guild not in (select distinct guild from characters where bog_time > datetime('now','-7 days') and guild is not null));
