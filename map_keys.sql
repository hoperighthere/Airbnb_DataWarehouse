insert into public.map_keys(listing_id,review_id,reviewer_id,host_id)
with ct as
(
	SELECT * FROM public.dblink
    ('demo','SELECT distinct l.id,r.id,r.reviewer_id,l.host_id
	FROM public."Listings" l left join public."Reviews" r on l.id=r.listing_id	 
	')
    AS DATA(listing_id bigint,review_id bigint,reviewer_id bigint,host_id bigint)
)
select * from ct 


alter table public.map_keys
add column reviewer_key integer,
add column host_key integer,
add column listing_key integer 
add column location_key integer 



WITH ct AS (
    SELECT * FROM public.dblink(
        'demo',
        'SELECT DISTINCT l.id AS listing_id, l.listing_url
         FROM public."Listings" l'
    ) AS DATA(listing_id BIGINT, listing_url TEXT)
)
UPDATE public.map_keys mk
SET listing_key = dl.listing_id
FROM public.dimlisting dl
JOIN ct ON ct.listing_url = dl.listing_url
WHERE mk.listing_id = ct.listing_id;


WITH ct AS (
    SELECT * FROM public.dblink(
        'demo',
        'SELECT DISTINCT l.id AS listing_id, l.latitude,l.longitude,l.neighbourhood_cleansed,l.neighbourhood_group_cleansed
         FROM public."Listings" l'
    ) AS DATA(
		listing_id BIGINT,
		latitude real,
		longitude real,
		neighbourhood text,
        neighbourhood_group text )
)
UPDATE public.map_keys mk
SET location_key = dl.location_id
FROM public.dimlocation dl
left JOIN ct ON ct.latitude = dl.latitude
and ct.longitude = dl.longitude
and ct.neighbourhood = dl.neighbourhood
and ct.neighbourhood_group = dl.neighbourhood_group
WHERE mk.listing_id = ct.listing_id;



WITH ct AS (
    SELECT * FROM public.dblink(
        'demo',
        'SELECT DISTINCT l.host_id, l.host_name,l.host_url
         FROM public."Listings" l'
    ) AS DATA(
		host_id BIGINT,
		host_name character varying(70),
        host_url text )
)
UPDATE public.map_keys mk
SET host_key = dh.host_id
FROM public.dimhosts dh
left JOIN ct 
on ct.host_url = dh.host_url
WHERE mk.host_id = ct.host_id;



WITH ct AS (
    SELECT * FROM public.dblink(
        'demo',
        'SELECT DISTINCT r.reviewer_id,r.date,r.reviewer_name,r.comments
         FROM public."Reviews" r'
    ) AS DATA(
		reviewer_id BIGINT,
		date date, 
		reviewer_name character varying(70),
        comments text )
)
UPDATE public.map_keys mk
SET reviewer_key = dr.reviewer_id
FROM public.dimreviewers dr
left JOIN ct 
 on ct.reviewer_name = dr.reviewer_name
and ct.date = dr.review_date
and ct.comments = dr.comments

WHERE mk.reviewer_id = ct.reviewer_id;




