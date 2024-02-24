insert into public.dimreviewers(review_date,reviewer_name,comments)
with ct as
(
	SELECT * FROM public.dblink
    ('demo','SELECT distinct date,reviewer_name,comments
	FROM public."Reviews" 
	')
    AS DATA(		
    review_date date,
    reviewer_name character varying(70),
    comments text)
)
select * from ct 