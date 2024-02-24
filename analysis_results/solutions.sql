-- what was the cheapest most avaliable listing in Jan 2024? (the cheapest listing which was avaliable the most of the month)
with ct as (
select listing_id,price,count(*) from public.bookingsfact b
join public.dimdate d on b.booking_date = d.date_id
where d.date >= '2024-01-01' AND d.date < '2024-02-01' and b.has_availability = true
group by 1,2 
order by 3 desc,2 asc)
select ct.listing_id,dl.listing_name,ct.price from ct join public.dimlisting dl using(listing_id)
limit 50
-- where listing_id = 2481


-- what are the most reviewed listings in November 2023 ?
with ct as (
select r.listing_id,count(*) as cnt_reviews from public.reviewsfact r
left join public.dimreviewers dr on dr.reviewer_id = r.reviewer_id
where extract(month from dr.review_date) = 11 and extract(year from dr.review_date) = 2023
group by 1
order by 2 desc)
select ct.listing_id,dl.listing_name,ct.cnt_reviews from ct join public.dimlisting dl using(listing_id)
limit 50
-- where listing_id = 17471


-- what is the most expensive neighbourhood in Barcelona ?
select dl.neighbourhood, avg(price) as avg_price_for_neighbourhood from public.bookingsfact b
left join public.dimlocation dl using(location_id)
group by dl.neighbourhood
order by 2 desc

-- el Guinardó


-- Recommend me a listing if I am :
-- A man with his wife and 2 children looking for a week vacation around March 2024.
select l.* from public.bookingsfact b
join public.dimdate d on b.booking_date = d.date_id
join public.dimlisting l using(listing_id)
where d.date >= '2024-03-01' AND d.date < '2024-04-01' 
and b.has_availability = true
and accommodates between 4 and 5
and (l.bedrooms = 2 or l.bedrooms = 3)
and l.beds = 3
and b.maximum_nights = 7

-- A colleage student with 4 other students who don't have alot of money and want to spend the new year's eve in Barcelona with perhaps two days before and/or two days after.

select l.*,b.price from public.bookingsfact b
join public.dimdate d on b.booking_date = d.date_id
join public.dimlisting l using(listing_id)
where d.date >= '2023-12-28' AND d.date < '2024-01-03' 
and b.has_availability = true
and accommodates = 5
-- and l.beds = 5
and b.maximum_nights between 2 and 5 
order by b.price 
 


