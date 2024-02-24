insert into public.dimlisting(listing_url,listing_name,picture_url,
							 property_type,room_type,bedrooms,beds,bathrooms,bathrooms_text,license,
							 avg_price_2023,minimum_minimum_nights_2024,maximum_minimum_nights_2024,
							 minimum_maximum_nights_2024,maximum_maximum_nights_2024)
with ct as
(
	SELECT * FROM public.dblink
    ('demo','SELECT distinct listing_url,name,picture_url,property_type,room_type,bedrooms,beds,bathroom,bathrooms_text,
	 license,price,minimum_minimum_nights,maximum_minimum_nights,minimum_maximum_nights,maximum_maximum_nights
	FROM public."Listings" 
	')
    AS DATA(
    listing_url text,
    listing_name text,
    picture_url text,
    property_type text,
    room_type text,
    bedrooms integer,
    beds integer,
    bathrooms real,
    bathrooms_text text,
    license text,
    avg_price_2023 real,
    minimum_minimum_nights_2024 integer,
    maximum_minimum_nights_2024 integer,
    minimum_maximum_nights_2024 integer,
    maximum_maximum_nights_2024 integer)
)
select * from ct 
