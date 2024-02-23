-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.

BEGIN;

-- Drop the table if it exists
DROP TABLE IF EXISTS public.BookingsFact;

-- Create the BookingsFact table
CREATE TABLE IF NOT EXISTS public.BookingsFact
(
    booking_id serial NOT NULL,
    listing_id integer,
    host_id integer,
    location_id integer,
    booking_date integer,
    accommodates integer,
    price real,
    has_availability boolean,
    instant_bookable boolean,
    minimum_nights integer,
    maximum_nights integer,
    availability_30 integer,
    availability_60 integer,
    availability_90 integer,
    availability_365 integer,
    PRIMARY KEY (booking_id)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS public.DimReviewers;

-- Create the DimReviewers table
CREATE TABLE IF NOT EXISTS public.DimReviewers
(
    reviewer_id serial NOT NULL,
    review_date date,
    reviewer_name character varying(70),
    comments text,
    PRIMARY KEY (reviewer_id)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS public.DimLocation;

-- Create the DimLocation table
CREATE TABLE IF NOT EXISTS public.DimLocation
(
    location_id serial NOT NULL,
    latitude real,
    longitude real,
    neighbourhood text,
    neighbourhood_group text,
    city character varying(70),
    country character varying(70),
    PRIMARY KEY (location_id)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS public.DimDate;

-- Create the DimDate table
CREATE TABLE IF NOT EXISTS public.DimDate
(
    date_id serial NOT NULL,
    date date,
    day integer,
    month integer,
    year integer,
    PRIMARY KEY (date_id)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS public.DimHosts;

-- Create the DimHosts table
CREATE TABLE IF NOT EXISTS public.DimHosts
(
    host_id serial NOT NULL,
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
    calculated_host_listings_count_shared_rooms integer,
    PRIMARY KEY (host_id)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS public.ReviewsFact;

-- Create the ReviewsFact table
CREATE TABLE IF NOT EXISTS public.ReviewsFact
(
    review_id serial NOT NULL,
    listing_id integer,
    reviewer_id integer,
    first_review integer,
    last_review integer,
    update_date integer,
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
    reviews_per_month real,
    PRIMARY KEY (review_id)
);

-- Drop the table if it exists
DROP TABLE IF EXISTS public.DimListing;

-- Create the DimListing table
CREATE TABLE IF NOT EXISTS public.DimListing
(
    listing_id serial NOT NULL,
    listing_url text,
    listing_name text,
    neighborhood_overview text,
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
    maximum_maximum_nights_2024 integer,
    PRIMARY KEY (listing_id)
);

-- Add foreign key constraints

ALTER TABLE IF EXISTS public.BookingsFact
    ADD CONSTRAINT listing_id_fk FOREIGN KEY (listing_id)
    REFERENCES public.DimListing (listing_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.BookingsFact
    ADD CONSTRAINT host_id_fk FOREIGN KEY (host_id)
    REFERENCES public.DimHosts (host_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.BookingsFact
    ADD CONSTRAINT location_id_fk FOREIGN KEY (location_id)
    REFERENCES public.DimLocation (location_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.BookingsFact
    ADD CONSTRAINT booking_date_fk FOREIGN KEY (booking_date)
    REFERENCES public.DimDate (date_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.ReviewsFact
    ADD CONSTRAINT listing_id_fk FOREIGN KEY (listing_id)
    REFERENCES public.DimListing (listing_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.ReviewsFact
    ADD CONSTRAINT reviewer_id_fk FOREIGN KEY (reviewer_id)
    REFERENCES public.DimReviewers (reviewer_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.ReviewsFact
    ADD CONSTRAINT first_review_fk FOREIGN KEY (first_review)
    REFERENCES public.DimDate (date_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.ReviewsFact
    ADD CONSTRAINT last_review_fk FOREIGN KEY (last_review)
    REFERENCES public.DimDate (date_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.ReviewsFact
    ADD CONSTRAINT update_date_fk FOREIGN KEY (update_date)
    REFERENCES public.DimDate (date_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;