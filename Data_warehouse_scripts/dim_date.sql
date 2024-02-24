insert into dimdate(date,day,month,year)
SELECT
	datum as Date,
	extract(year from datum) AS Year,
	extract(month from datum) AS Month,
	extract(day from datum) AS Day

	FROM (
	SELECT '2008-01-01'::DATE + sequence.day AS datum
	FROM generate_series(0,6209) AS sequence(day)
	GROUP BY sequence.day
     ) DQ
order by 1 desc