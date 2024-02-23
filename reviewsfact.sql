insert into public.reviewsfact(listing_id,reviewer_id,first_review,last_review,update_date,number_of_reviews,number_of_reviews_l12m,
							  number_of_reviews_l30d,review_scores_rating,review_scores_accuracy,review_scores_cleanliness,
							  review_scores_checkin,review_scores_communication,review_scores_location,review_scores_value,reviews_per_month)
with ct as
(
	SELECT * FROM public.dblink
    ('demo','SELECT distinct r.id,first_review,last_review,l.calendar_last_scraped,l.number_of_reviews,l.number_of_reviews_ltm,
							  l.number_of_reviews_l30d,l.review_scores_rating,l.review_scores_accuracy,l.review_scores_cleanliness,
							  l.review_scores_checkin,l.review_scores_communication,l.review_scores_location,l.review_scores_value,l.reviews_per_month
	FROM public."Listings" l join public."Reviews" r on l.id=r.listing_id
	')
    AS DATA(
	review_id bigint,	
    first_review date,
    last_review date,
    update_date date,
    number_of_reviews integer,
    number_of_reviews_l12m integer,
    number_of_reviews_l30d integer,
    review_scores_rating real,
    review_scores_accuracy real,
    review_scores_cleanliness real,
    review_scores_checkin real,
    review_scores_communication real,
    review_scores_location real,
    review_scores_value real,
    reviews_per_month real)
)

select 
mk.listing_key,
mk.reviewer_key,
fr.date_id as first_review,
lr.date_id as last_review,
cls.date_id as update_date,
ct.number_of_reviews,
ct.number_of_reviews_l12m,
ct.number_of_reviews_l30d,
ct.review_scores_rating,
ct.review_scores_accuracy,
ct.review_scores_cleanliness,
ct.review_scores_checkin,
ct.review_scores_communication,
ct.review_scores_location,
ct.review_scores_value,
ct.reviews_per_month
from ct
join public.map_keys mk on ct.review_id = mk.review_id
join public.dimdate fr on ct.first_review = fr.date
join public.dimdate lr on ct.last_review = lr.date
join public.dimdate cls on ct.update_date = cls.date















