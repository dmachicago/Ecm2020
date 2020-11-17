
create table StateAbbreviations 
(
    Abbrev nvarchar(10) not null,
    StateName nvarchar(100) not null
)

create index PKI_StateAbbreviations on StateAbbreviations
(
Abbrev ,StateName 
)

select (Abbrev ,StateName) from StateAbbreviations order by Abbrev 

insert into StateAbbreviations (StateName, abbrev) values ('Alabama','AL');
insert into StateAbbreviations (StateName, abbrev) values ('Alaska','AK');
insert into StateAbbreviations (StateName, abbrev) values ('American Samoa','AS');
insert into StateAbbreviations (StateName, abbrev) values ('Arizona','AZ');
insert into StateAbbreviations (StateName, abbrev) values ('Arkansas','AR');
insert into StateAbbreviations (StateName, abbrev) values ('California','CA');
insert into StateAbbreviations (StateName, abbrev) values ('Colorado','CO');
insert into StateAbbreviations (StateName, abbrev) values ('Connecticut','CT');
insert into StateAbbreviations (StateName, abbrev) values ('Delaware','DE');
insert into StateAbbreviations (StateName, abbrev) values ('Dist. of Columbia','DC');
insert into StateAbbreviations (StateName, abbrev) values ('Florida','FL');
insert into StateAbbreviations (StateName, abbrev) values ('Georgia','GA');
insert into StateAbbreviations (StateName, abbrev) values ('Guam','GU');
insert into StateAbbreviations (StateName, abbrev) values ('Hawaii','HI');
insert into StateAbbreviations (StateName, abbrev) values ('Idaho','ID');
insert into StateAbbreviations (StateName, abbrev) values ('Illinois','IL');
insert into StateAbbreviations (StateName, abbrev) values ('Indiana','IN');
insert into StateAbbreviations (StateName, abbrev) values ('Iowa','IA');
insert into StateAbbreviations (StateName, abbrev) values ('Kansas','KS');
insert into StateAbbreviations (StateName, abbrev) values ('Kentucky','KY');
insert into StateAbbreviations (StateName, abbrev) values ('Louisiana','LA');
insert into StateAbbreviations (StateName, abbrev) values ('Maine','ME');
insert into StateAbbreviations (StateName, abbrev) values ('Maryland','MD');
insert into StateAbbreviations (StateName, abbrev) values ('Marshall Islands','MH');
insert into StateAbbreviations (StateName, abbrev) values ('Massachusetts','MA');
insert into StateAbbreviations (StateName, abbrev) values ('Michigan','MI');
insert into StateAbbreviations (StateName, abbrev) values ('Micronesia','FM');
insert into StateAbbreviations (StateName, abbrev) values ('Minnesota','MN');
insert into StateAbbreviations (StateName, abbrev) values ('Mississippi','MS');
insert into StateAbbreviations (StateName, abbrev) values ('Missouri','MO');
insert into StateAbbreviations (StateName, abbrev) values ('Montana','MT');
insert into StateAbbreviations (StateName, abbrev) values ('Nebraska','NE');
insert into StateAbbreviations (StateName, abbrev) values ('Nevada','NV');
insert into StateAbbreviations (StateName, abbrev) values ('New Hampshire','NH');
insert into StateAbbreviations (StateName, abbrev) values ('New Jersey','NJ');
insert into StateAbbreviations (StateName, abbrev) values ('New Mexico','NM');
insert into StateAbbreviations (StateName, abbrev) values ('New York','NY');
insert into StateAbbreviations (StateName, abbrev) values ('North Carolina','NC');
insert into StateAbbreviations (StateName, abbrev) values ('North Dakota','ND');
insert into StateAbbreviations (StateName, abbrev) values ('Northern Marianas','MP');
insert into StateAbbreviations (StateName, abbrev) values ('Ohio','OH');
insert into StateAbbreviations (StateName, abbrev) values ('Oklahoma','OK');
insert into StateAbbreviations (StateName, abbrev) values ('Oregon','OR');
insert into StateAbbreviations (StateName, abbrev) values ('Palau','PW');
insert into StateAbbreviations (StateName, abbrev) values ('Pennsylvania','PA');
insert into StateAbbreviations (StateName, abbrev) values ('Puerto Rico','PR');
insert into StateAbbreviations (StateName, abbrev) values ('Rhode Island','RI');
insert into StateAbbreviations (StateName, abbrev) values ('South Carolina','SC');
insert into StateAbbreviations (StateName, abbrev) values ('South Dakota','SD');
insert into StateAbbreviations (StateName, abbrev) values ('Tennessee','TN');
insert into StateAbbreviations (StateName, abbrev) values ('Texas','TX');
insert into StateAbbreviations (StateName, abbrev) values ('Utah','UT');
insert into StateAbbreviations (StateName, abbrev) values ('Vermont','VT');
insert into StateAbbreviations (StateName, abbrev) values ('Virginia','VA');
insert into StateAbbreviations (StateName, abbrev) values ('Virgin Islands','VI');
insert into StateAbbreviations (StateName, abbrev) values ('Washington','WA');
insert into StateAbbreviations (StateName, abbrev) values ('West Virginia','WV');
insert into StateAbbreviations (StateName, abbrev) values ('Wisconsin','WI');
insert into StateAbbreviations (StateName, abbrev) values ('Wyoming','WY');
