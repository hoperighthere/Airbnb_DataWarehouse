insert into public.timp(listing_id,booking_date,accommodates,price,has_availability,instant_bookable,
							  minimum_nights,maximum_nights,availability_30,availability_60,availability_90,availability_365)
with ct as
(
	SELECT * FROM public.dblink
    ('demo','SELECT distinct c.listing_id,
	 c.date,l.accommodates,c.price,c.available,l.instant_bookable,
	 c.minimum_nights,c.maximum_nights,l.availability_30,l.availability_60,l.availability_90,l.availability_365
	FROM public."Listings" l join public."Calendar" c on l.id = c.listing_id
	')
    AS DATA(
	listing_id bigint,
    booking_date date,
    accommodates integer,
    price real,
    has_availability boolean,
    instant_bookable boolean,
    minimum_nights integer,
    maximum_nights integer,
    availability_30 integer,
    availability_60 integer,
    availability_90 integer,
    availability_365 integer))
select * from ct	



