-- What is the total sales for the 4 weeks before and after 2020-06-15? 
-- What is the growth or reduction rate in actual values and percentage of sales?

-- SELECT WEEK('2020-06-15'); week number 24 

WITH before_change AS
(
 SELECT SUM(sales) AS before_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 20 AND 23 AND calender_year = 2020
),
after_change AS
(
 SELECT SUM(sales) AS after_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 24 AND 27 AND calender_year = 2020
)

SELECT before_change_total_sales, after_change_total_sales, 
	   (after_change_total_sales - before_change_total_sales) as growth_or_reduction,
	ROUND(((after_change_total_sales - before_change_total_sales) / before_change_total_sales)*100,2) as growth_or_reduction_percentage
FROM before_change, after_change;
 
 +---------------------------+--------------------------+---------------------+--------------------------------+
| before_change_total_sales | after_change_total_sales | growth_or_reduction | growth_or_reduction_percentage |
+---------------------------+--------------------------+---------------------+--------------------------------+
|                2345878357 |               2318994169 |           -26884188 |                          -1.15 |
+---------------------------+--------------------------+---------------------+--------------------------------+


-- What about the entire 12 weeks before and after?

WITH before_change AS
(
SELECT SUM(sales) AS before_change_total_sales  FROM clean_weekly_sales
WHERE week_number BETWEEN 20-11 AND 23 AND calender_year = 2020
),
after_change AS
(
SELECT SUM(sales) AS after_change_total_sales  FROM clean_weekly_sales
WHERE week_number BETWEEN 24 AND 24+11 AND calender_year = 2020
)

SELECT before_change_total_sales, after_change_total_sales, 
	   (after_change_total_sales - before_change_total_sales) as growth_or_reduction,
	ROUND(((after_change_total_sales - before_change_total_sales) / before_change_total_sales)*100,2) as growth_or_reduction_percentage
FROM before_change, after_change;

+---------------------------+--------------------------+---------------------+--------------------------------+
| before_change_total_sales | after_change_total_sales | growth_or_reduction | growth_or_reduction_percentage |
+---------------------------+--------------------------+---------------------+--------------------------------+
|                7126273147 |               6973947753 |          -152325394 |                          -2.14 |
+---------------------------+--------------------------+---------------------+--------------------------------+


-- How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

-- before and after 4 weeks

WITH before_change AS
(
 SELECT calender_year,SUM(sales) AS before_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 20 AND 23 
 GROUP BY calender_year
),
after_change AS
(
 SELECT calender_year,SUM(sales) AS after_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 24 AND 27 
 GROUP BY calender_year
)
SELECT before_change.calender_year, before_change_total_sales,after_change_total_sales,
(after_change_total_sales - before_change_total_sales) as growth_or_reduction,
ROUND(((after_change_total_sales - before_change_total_sales) / before_change_total_sales)*100,2) as growth_or_reduction_percentage 
FROM before_change
JOIN after_change
ON before_change.calender_year = after_change.calender_year
ORDER BY before_change.calender_year;


+---------------+---------------------------+--------------------------+---------------------+--------------------------------+
| calender_year | before_change_total_sales | after_change_total_sales | growth_or_reduction | growth_or_reduction_percentage |
+---------------+---------------------------+--------------------------+---------------------+--------------------------------+
|          2018 |                2125140809 |               2129242914 |             4102105 |                           0.19 |
|          2019 |                2249989796 |               2252326390 |             2336594 |                           0.10 |
|          2020 |                2345878357 |               2318994169 |           -26884188 |                          -1.15 |
+---------------+---------------------------+--------------------------+---------------------+--------------------------------+


-- before and after 12 weeks

WITH before_change AS
(
SELECT calender_year,SUM(sales) AS before_change_total_sales  FROM clean_weekly_sales
WHERE week_number BETWEEN 20-11 AND 23 
GROUP BY calender_year
),
after_change AS
(
SELECT calender_year,SUM(sales) AS after_change_total_sales  FROM clean_weekly_sales
WHERE week_number BETWEEN 24 AND 24+11 
GROUP BY calender_year
)
SELECT before_change.calender_year, before_change_total_sales,after_change_total_sales,
(after_change_total_sales - before_change_total_sales) as growth_or_reduction,
ROUND(((after_change_total_sales - before_change_total_sales) / before_change_total_sales)*100,2) as growth_or_reduction_percentage 
FROM before_change
JOIN after_change
ON before_change.calender_year = after_change.calender_year
ORDER BY before_change.calender_year;
 
 +---------------+---------------------------+--------------------------+---------------------+--------------------------------+
| calender_year | before_change_total_sales | after_change_total_sales | growth_or_reduction | growth_or_reduction_percentage |
+---------------+---------------------------+--------------------------+---------------------+--------------------------------+
|          2018 |                6396562317 |               6500818510 |           104256193 |                           1.63 |
|          2019 |                6883386397 |               6862646103 |           -20740294 |                          -0.30 |
|          2020 |                7126273147 |               6973947753 |          -152325394 |                          -2.14 |
+---------------+---------------------------+--------------------------+---------------------+--------------------------------+