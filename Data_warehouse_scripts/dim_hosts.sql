insert into public.dimhosts(host_name,host_url,host_since,host_location,host_about,host_response_time,
						   host_response_rate,host_acceptance_rate,host_is_superhost,host_thumbnail_url,
						   host_picture_url,host_neighbourhood,host_listings_count,host_total_listings_count,
						   host_verifications,host_has_profile_pic,host_identity_verified,calculated_host_listings_count,
						   calculated_host_listings_count_entire_homes,calculated_host_listings_count_private_rooms,calculated_host_listings_count_shared_rooms)
with ct as
(
	SELECT * FROM public.dblink
    ('demo','SELECT distinct host_name,host_url,host_since,host_location,host_about,host_response_time,
						   host_response_rate,host_acceptance_rate,host_is_superhost,host_thumbnail_url,
						   host_picture_url,host_neighbourhood,host_listings_count,host_total_listings_count,
						   host_verifications,host_has_profile_pic,host_identity_verified,calculated_host_listings_count,
						   calculated_host_listings_count_entire_homes,calculated_host_listings_count_private_rooms,calculated_host_listings_count_shared_rooms
	FROM public."Listings"
	')
    AS DATA(
    host_name character varying(70),
    host_url text,
    host_since date,
    host_location character varying(70),
    host_about text,
    host_response_time text,
    host_response_rate real,
    host_acceptance_rate real,
    host_is_superhost boolean,
    host_thumbnail_url text,
    host_picture_url text,
    host_neighbourhood character varying(70),
    host_listings_count integer,
    host_total_listings_count integer,
    host_verifications text,
    host_has_profile_pic boolean,
    host_identity_verified boolean,
    calculated_host_listings_count integer,
    calculated_host_listings_count_entire_homes integer,
    calculated_host_listings_count_private_rooms integer,
    calculated_host_listings_count_shared_rooms integer
)
)


select * from ct
















