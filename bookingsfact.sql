insert into public.bookingsfact(listing_id,host_id,location_id,booking_date,accommodates,price,has_availability,instant_bookable,
							  minimum_nights,maximum_nights,availability_30,availability_60,availability_90,availability_365)
select 
    mk.listing_key as listing_id,
    mk.host_key as host_id,
    mk.location_key as location_id,
    bd.date_id as booking_date, 
    ct.accommodates,
    ct.price,
    ct.has_availability,
    ct.instant_bookable,
    ct.minimum_nights,
    ct.maximum_nights,
    ct.availability_30,
    ct.availability_60,
    ct.availability_90,
    ct.availability_365
from public.timp ct
left join public.dimdate bd on ct.booking_date = bd.date
left join (select distinct(listing_id),listing_key,host_key,location_key from public.map_keys) mk on ct.listing_id = mk.listing_id


