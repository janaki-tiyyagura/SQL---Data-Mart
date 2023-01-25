/* Which areas of the business have the highest negative impact in sales metrics performance in 2020 
for the 12 week before and after period?

region
platform
age_band
demographic
customer_type
*/
-- REGION


WITH before_change AS
(
 SELECT region,SUM(sales) AS before_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 20-11 AND 23 AND calender_year = 2020
 GROUP BY region
),
after_change AS
(
 SELECT region,SUM(sales) AS after_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 24 AND 24+11 AND calender_year = 2020
 GROUP BY region
)
SELECT before_change.region,before_change_total_sales, after_change_total_sales, 
	   (after_change_total_sales - before_change_total_sales) as growth_or_reduction,
	ROUND(((after_change_total_sales - before_change_total_sales) / before_change_total_sales)*100,2) as growth_or_reduction_percentage
 FROM before_change
 JOIN after_change
 ON before_change.region = after_change.region
 ORDER BY growth_or_reduction_percentage;
 
 
 +---------------+---------------------------+--------------------------+---------------------+--------------------------------+
| region        | before_change_total_sales | after_change_total_sales | growth_or_reduction | growth_or_reduction_percentage |
+---------------+---------------------------+--------------------------+---------------------+--------------------------------+
| ASIA          |                1637244466 |               1583807621 |           -53436845 |                          -3.26 |
| OCEANIA       |                2354116790 |               2282795690 |           -71321100 |                          -3.03 |
| SOUTH AMERICA |                 213036207 |                208452033 |            -4584174 |                          -2.15 |
| CANADA        |                 426438454 |                418264441 |            -8174013 |                          -1.92 |
| USA           |                 677013558 |                666198715 |           -10814843 |                          -1.60 |
| AFRICA        |                1709537105 |               1700390294 |            -9146811 |                          -0.54 |
| EUROPE        |                 108886567 |                114038959 |             5152392 |                           4.73 |
+---------------+---------------------------+--------------------------+---------------------+--------------------------------+

-- platform

WITH before_change AS
(
 SELECT platform,SUM(sales) AS before_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 20-11 AND 23 AND calender_year = 2020
 GROUP BY platform
),
after_change AS
(
 SELECT platform,SUM(sales) AS after_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 24 AND 24+11 AND calender_year = 2020
 GROUP BY platform
)

SELECT before_change.platform,before_change_total_sales, after_change_total_sales, 
	   (after_change_total_sales - before_change_total_sales) as growth_or_reduction,
	ROUND(((after_change_total_sales - before_change_total_sales) / before_change_total_sales)*100,2) as growth_or_reduction_percentage
 FROM before_change
 JOIN after_change
 ON before_change.platform = after_change.platform
 ORDER BY growth_or_reduction_percentage;
 
 +----------+---------------------------+--------------------------+---------------------+--------------------------------+
| platform | before_change_total_sales | after_change_total_sales | growth_or_reduction | growth_or_reduction_percentage |
+----------+---------------------------+--------------------------+---------------------+--------------------------------+
| Retail   |                6906861113 |               6738777279 |          -168083834 |                          -2.43 |
| Shopify  |                 219412034 |                235170474 |            15758440 |                           7.18 |
+----------+---------------------------+--------------------------+---------------------+--------------------------------+


-- demographic

WITH before_change AS
(
 SELECT demographic,SUM(sales) AS before_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 20-11 AND 23 AND calender_year = 2020
 GROUP BY demographic
),
after_change AS
(
 SELECT demographic,SUM(sales) AS after_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 24 AND 24+11 AND calender_year = 2020
 GROUP BY demographic
 )
SELECT before_change.demographic,before_change_total_sales, after_change_total_sales, 
	   (after_change_total_sales - before_change_total_sales) as growth_or_reduction,
	ROUND(((after_change_total_sales - before_change_total_sales) / before_change_total_sales)*100,2) as growth_or_reduction_percentage
 FROM before_change
 JOIN after_change
 ON before_change.demographic = after_change.demographic
 ORDER BY growth_or_reduction_percentage;
 
 +-------------+---------------------------+--------------------------+---------------------+--------------------------------+
| demographic | before_change_total_sales | after_change_total_sales | growth_or_reduction | growth_or_reduction_percentage |
+-------------+---------------------------+--------------------------+---------------------+--------------------------------+
| unknown     |                2764354464 |               2671961443 |           -92393021 |                          -3.34 |
| Families    |                2328329040 |               2286009025 |           -42320015 |                          -1.82 |
| Couples     |                2033589643 |               2015977285 |           -17612358 |                          -0.87 |
+-------------+---------------------------+--------------------------+---------------------+--------------------------------+

-- customer_type

WITH before_change AS
(
 SELECT customer_type,SUM(sales) AS before_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 20-11 AND 23 AND calender_year = 2020
 GROUP BY customer_type
),
after_change AS
(
 SELECT customer_type,SUM(sales) AS after_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 24 AND 24+11 AND calender_year = 2020
 GROUP BY customer_type
)

SELECT before_change.customer_type,before_change_total_sales, after_change_total_sales, 
	   (after_change_total_sales - before_change_total_sales) as growth_or_reduction,
	ROUND(((after_change_total_sales - before_change_total_sales) / before_change_total_sales)*100,2) as growth_or_reduction_percentage
 FROM before_change
 JOIN after_change
 ON before_change.customer_type = after_change.customer_type
 ORDER BY growth_or_reduction_percentage;
 
 +---------------+---------------------------+--------------------------+---------------------+--------------------------------+
| customer_type | before_change_total_sales | after_change_total_sales | growth_or_reduction | growth_or_reduction_percentage |
+---------------+---------------------------+--------------------------+---------------------+--------------------------------+
| Guest         |                2573436301 |               2496233635 |           -77202666 |                          -3.00 |
| Existing      |                3690116427 |               3606243454 |           -83872973 |                          -2.27 |
| New           |                 862720419 |                871470664 |             8750245 |                           1.01 |
+---------------+---------------------------+--------------------------+---------------------+--------------------------------+

-- age brand

WITH before_change AS
(
 SELECT age_brand,SUM(sales) AS before_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 20-11 AND 23 AND calender_year = 2020
 GROUP BY age_brand
),
 fter_change AS
(
 SELECT age_brand,SUM(sales) AS after_change_total_sales  FROM clean_weekly_sales
 WHERE week_number BETWEEN 24 AND 24+11 AND calender_year = 2020
 GROUP BY age_brand
)
SELECT before_change.age_brand,before_change_total_sales, after_change_total_sales, 
	   (after_change_total_sales - before_change_total_sales) as growth_or_reduction,
	ROUND(((after_change_total_sales - before_change_total_sales) / before_change_total_sales)*100,2) as growth_or_reduction_percentage
 FROM before_change
 JOIN after_change
 ON before_change.age_brand = after_change.age_brand
 ORDER BY growth_or_reduction_percentage;
 
 +--------------+---------------------------+--------------------------+---------------------+--------------------------------+
| age_brand    | before_change_total_sales | after_change_total_sales | growth_or_reduction | growth_or_reduction_percentage |
+--------------+---------------------------+--------------------------+---------------------+--------------------------------+
| unknown      |                2764354464 |               2671961443 |           -92393021 |                          -3.34 |
| Middle Aged  |                1164847640 |               1141853348 |           -22994292 |                          -1.97 |
| Retirees     |                2395264515 |               2365714994 |           -29549521 |                          -1.23 |
| Young Adults |                 801806528 |                794417968 |            -7388560 |                          -0.92 |
+--------------+---------------------------+--------------------------+---------------------+--------------------------------+