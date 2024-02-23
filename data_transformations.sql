-- Listings
-- select count(l.*) from public."Listings" l
-- select distinct(l.*) from public."Listings" l
-- select * from public."Listings" limit 10
-- select min(host_since) from "Listings"
-- where host_location ilike '%italy%' --or neighbourhood is null



with ct as (SELECT 
    id,name,accommodates,bathroom,beds,bedrooms,bathrooms_text,property_type,
--     extracting numerical values from text(name_column):
    substring(name FROM '\d+(?= bedroom)') AS bedrooms,
    substring(name FROM '\d+(?= \s*bed[^room])') AS beds,
    substring(name FROM '\d+\.*\d*(?= \w*\s*bath)') AS bathrooms
FROM public."Listings")
select * from ct 
limit 100

-- Alter the "Listings" table by adding a new column named 'bathroom' of type real (floating point number)
ALTER TABLE "Listings"
ADD column bathroom real;

-- Update the newly added 'bathroom' column in the "Listings" table
-- The value is set by extracting numerical values from the 'name' column where it matches patterns indicating bathroom information
-- The extracted string is converted to a real (floating point number) type
UPDATE "Listings"
SET bathroom = substring(name FROM '\d+\.*\d*(?= \w*\s*bath)')::real;

-- Update the 'bathroom' column in the "Listings" table
UPDATE "Listings"
SET bathroom = CASE 
                -- If 'bathrooms_text' indicates any type of half-bath, set 'bathroom' to 0.5
                WHEN bathrooms_text = 'Half-bath' 
                     OR bathrooms_text = 'Shared half-bath' 
                     OR bathrooms_text = 'Private half-bath' THEN 0.5
                -- If none of the above conditions are met, leave 'bathroom' as it is
                ELSE bathroom
              END
-- Apply this update only to rows where 'bathroom' is currently null
WHERE bathroom is null;


-- Alter the "Listings" table by adding a new column named 'bedrooms' of type real (floating point number)
ALTER TABLE "Listings"
ADD column bedrooms real;

-- Update the newly added 'bedrooms' column in the "Listings" table
-- The value is set by extracting numerical values from the 'name' column where it matches patterns indicating bedroom information
-- The extracted string is converted to a real (floating point number) type
UPDATE "Listings"
SET bedrooms = substring(name FROM '\d+(?= bedroom)')::real;


-- Alter the data type of the columns in the "Listings" table to boolean
ALter table "Listings"
ALTER COLUMN host_is_superhost TYPE boolean USING host_is_superhost::boolean;

ALter table "Listings"
ALTER COLUMN host_has_profile_pic TYPE boolean USING host_has_profile_pic::boolean;

ALter table "Listings"
ALTER COLUMN host_identity_verified TYPE boolean USING host_identity_verified::boolean;

ALter table "Listings"
ALTER COLUMN has_availability TYPE boolean USING has_availability::boolean;

ALter table "Listings"
ALTER COLUMN instant_bookable TYPE boolean USING instant_bookable::boolean;


-- Update the 'price' column in the "Listings" table by removing the dollar sign ('$')

UPDATE public."Listings"
SET price = REPLACE(price, '$', '')
WHERE price LIKE '$%';

-- Update the column in the "Listings" table by converting percentage strings to real numbers

UPDATE public."Listings"
SET host_response_rate = CAST(REPLACE(host_response_rate, '%', '') AS REAL) / 100
WHERE host_response_rate LIKE '%\%%';

UPDATE public."Listings"
SET host_acceptance_rate = CAST(REPLACE(host_acceptance_rate, '%', '') AS REAL) / 100
WHERE host_acceptance_rate LIKE '%\%%';

-- return NULL if the 'host_acceptance_rate' equals 'N/A'; otherwise, it returns the column value unchanged
UPDATE public."Listings"
SET host_acceptance_rate = NULLIF(host_acceptance_rate, 'N/A')
WHERE host_acceptance_rate = 'N/A';

UPDATE public."Listings"
SET host_response_rate = NULLIF(host_response_rate, 'N/A')
WHERE host_response_rate = 'N/A';


UPDATE public."Listings"
SET host_response_time = NULLIF(host_response_time, 'N/A')
WHERE host_response_time = 'N/A';


UPDATE public."Listings"
SET price = REPLACE(price, ',', '')::REAL
WHERE price ~ '^[0-9,.]+$';

UPDATE public."Listings"
SET neighborhood_overview = REPLACE(neighborhood_overview, '<b />', '');
WHERE neighborhood_overview LIKE '%<b />%';

ALTER TABLE public."Listings"
ALTER COLUMN price TYPE REAL
USING price::REAL;

ALTER TABLE public."Listings"
ALTER COLUMN host_response_rate TYPE REAL
USING host_response_rate::REAL;

ALTER TABLE public."Listings"
ALTER COLUMN host_acceptance_rate TYPE REAL
USING host_acceptance_rate::REAL;


-- Calendar

ALter table "Calendar"
ALTER COLUMN available TYPE boolean USING available::boolean; 
 
 
-- Reviews

ALTER TABLE public."Reviews"
ALTER COLUMN date TYPE DATE USING date::DATE;

