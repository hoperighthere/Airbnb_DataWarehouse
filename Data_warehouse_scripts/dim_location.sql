insert into public.dimlocation(latitude,longitude,neighbourhood,neighbourhood_group)
with ct as
(
	SELECT * FROM public.dblink
    ('demo','SELECT distinct latitude,longitude,neighbourhood_cleansed,neighbourhood_group_cleansed
	FROM public."Listings" 
	')
    AS DATA(
	latitude real,
    longitude real,
    neighbourhood text,
    neighbourhood_group text)
)
select * from ct 


update public.dimlocation
set city = 'Barcelona';

update public.dimlocation
set country = 'Spain';