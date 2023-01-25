-- What day of the week is used for each week_date value?

SELECT DISTINCT(DAYNAME(week_date)) AS day_of_the_week
FROM clean_weekly_sales;

+-----------------+
| day_of_the_week |
+-----------------+
| Monday          |
+-----------------+

-- What range of week numbers are missing from the dataset?

WITH RECURSIVE total_weeks (week_number) AS 
(
    SELECT 1
    UNION ALL
    SELECT week_number + 1 FROM total_weeks
    WHERE week_number < 52
)
SELECT total_weeks.week_number
FROM total_weeks
LEFT JOIN clean_weekly_sales 
ON total_weeks.week_number = clean_weekly_sales.week_number
WHERE clean_weekly_sales.week_number IS NULL
ORDER BY total_weeks.week_number;

+-------------+
| week_number |
+-------------+
|           1 |
|           2 |
|           3 |
|           4 |
|           5 |
|           6 |
|           7 |
|           8 |
|           9 |
|          10 |
|          11 |
|          36 |
|          37 |
|          38 |
|          39 |
|          40 |
|          41 |
|          42 |
|          43 |
|          44 |
|          45 |
|          46 |
|          47 |
|          48 |
|          49 |
|          50 |
|          51 |
|          52 |
+-------------+

-- How many total transactions were there for each year in the dataset?


SELECT calender_year, SUM(transactions) AS total_transactions FROM clean_weekly_sales
GROUP BY calender_year
ORDER BY calender_year;

+---------------+--------------------+
| calender_year | total_transactions |
+---------------+--------------------+
|          2018 |          346406460 |
|          2019 |          365639285 |
|          2020 |          375813651 |
+---------------+--------------------+

-- What is the total sales for each region for each month?

SELECT region,month_number, SUM(sales) AS total_sales FROM clean_weekly_sales
GROUP BY region, month_number
ORDER BY region, month_number;

+---------------+--------------+-------------+
| region        | month_number | total_sales |
+---------------+--------------+-------------+
| AFRICA        |            3 |   567767480 |
| AFRICA        |            4 |  1911783504 |
| AFRICA        |            5 |  1647244738 |
| AFRICA        |            6 |  1767559760 |
| AFRICA        |            7 |  1960219710 |
| AFRICA        |            8 |  1809596890 |
| AFRICA        |            9 |   276320987 |
| ASIA          |            3 |   529770793 |
| ASIA          |            4 |  1804628707 |
| ASIA          |            5 |  1526285399 |
| ASIA          |            6 |  1619482889 |
| ASIA          |            7 |  1768844756 |
| ASIA          |            8 |  1663320609 |
| ASIA          |            9 |   252836807 |
| CANADA        |            3 |   144634329 |
| CANADA        |            4 |   484552594 |
| CANADA        |            5 |   412378365 |
| CANADA        |            6 |   443846698 |
| CANADA        |            7 |   477134947 |
| CANADA        |            8 |   447073019 |
| CANADA        |            9 |    69067959 |
| EUROPE        |            3 |    35337093 |
| EUROPE        |            4 |   127334255 |
| EUROPE        |            5 |   109338389 |
| EUROPE        |            6 |   122813826 |
| EUROPE        |            7 |   136757466 |
| EUROPE        |            8 |   122102995 |
| EUROPE        |            9 |    18877433 |
| OCEANIA       |            3 |   783282888 |
| OCEANIA       |            4 |  2599767620 |
| OCEANIA       |            5 |  2215657304 |
| OCEANIA       |            6 |  2371884744 |
| OCEANIA       |            7 |  2563459400 |
| OCEANIA       |            8 |  2432313652 |
| OCEANIA       |            9 |   372465518 |
| SOUTH AMERICA |            3 |    71023109 |
| SOUTH AMERICA |            4 |   238451531 |
| SOUTH AMERICA |            5 |   201391809 |
| SOUTH AMERICA |            6 |   218247455 |
| SOUTH AMERICA |            7 |   235582776 |
| SOUTH AMERICA |            8 |   221166052 |
| SOUTH AMERICA |            9 |    34175583 |
| USA           |            3 |   225353043 |
| USA           |            4 |   759786323 |
| USA           |            5 |   655967121 |
| USA           |            6 |   703878990 |
| USA           |            7 |   760331754 |
| USA           |            8 |   712002790 |
| USA           |            9 |   110532368 |
+---------------+--------------+-------------+

-- What is the total count of transactions for each platform?

SELECT platform, SUM(transactions) AS total_count_of_transactions
FROM clean_weekly_sales
GROUP BY platform;

+----------+-----------------------------+
| platform | total_count_of_transactions |
+----------+-----------------------------+
| Retail   |                  1081934227 |
| Shopify  |                     5925169 |
+----------+-----------------------------+

-- What is the percentage of sales for Retail vs Shopify for each month?

SELECT month_number,
ROUND((SUM(CASE WHEN platform = 'Retail' THEN sales END)/SUM(sales))*100.0,2) AS retail_percentage,
ROUND((SUM(CASE WHEN platform = 'Shopify' THEN sales END)/SUM(sales))*100.0,2) AS shopify_percentage
FROM clean_weekly_sales
GROUP BY month_number
ORDER BY month_number;

+--------------+-------------------+--------------------+
| month_number | retail_percentage | shopify_percentage |
+--------------+-------------------+--------------------+
|            3 |             97.54 |               2.46 |
|            4 |             97.59 |               2.41 |
|            5 |             97.30 |               2.70 |
|            6 |             97.27 |               2.73 |
|            7 |             97.29 |               2.71 |
|            8 |             97.08 |               2.92 |
|            9 |             97.38 |               2.62 |
+--------------+-------------------+--------------------+

-- What is the percentage of sales by demographic for each year in the dataset?

SELECT calender_year, 
ROUND((SUM(CASE WHEN demographic = 'Couples' THEN sales END)/SUM(sales))*100.0,2) AS couples_percentage,
ROUND((SUM(CASE WHEN demographic = 'Families' THEN sales END)/SUM(sales))*100.0,2) AS families_percentage,
ROUND((SUM(CASE WHEN demographic = 'unknown' THEN sales END)/SUM(sales))*100.0,2) AS unknown_percentage
FROM clean_weekly_sales
GROUP BY calender_year
ORDER BY calender_year;

+---------------+--------------------+---------------------+--------------------+
| calender_year | couples_percentage | families_percentage | unknown_percentage |
+---------------+--------------------+---------------------+--------------------+
|          2018 |              26.38 |               31.99 |              41.63 |
|          2019 |              27.28 |               32.47 |              40.25 |
|          2020 |              28.72 |               32.73 |              38.55 |
+---------------+--------------------+---------------------+--------------------+

-- Which age_band and demographic values contribute the most to Retail sales?

SELECT age_brand, demographic, SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE platform = 'Retail'
GROUP BY age_brand, demographic
ORDER BY total_sales DESC;

+--------------+-------------+-------------+
| age_brand    | demographic | total_sales |
+--------------+-------------+-------------+
| unknown      | unknown     | 16067285533 |
| Retirees     | Families    |  6634686916 |
| Retirees     | Couples     |  6370580014 |
| Middle Aged  | Families    |  4354091554 |
| Young Adults | Couples     |  2602922797 |
| Middle Aged  | Couples     |  1854160330 |
| Young Adults | Families    |  1770889293 |
+--------------+-------------+-------------+

-- Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify?
-- If not - how would you calculate it instead?

SELECT calender_year, platform, 
ROUND(AVG(avg_transactions)) AS avg_avg_transaction,
ROUND(SUM(sales) / sum(transactions)) AS normal_avg_transaction
FROM clean_weekly_sales
GROUP BY calender_year, platform
ORDER BY calender_year, platform;

---------------+----------+---------------------+------------------------+
| calender_year | platform | avg_avg_transaction | normal_avg_transaction |
+---------------+----------+---------------------+------------------------+
|          2018 | Retail   |                  43 |                     37 |
|          2018 | Shopify  |                 188 |                    192 |
|          2019 | Retail   |                  42 |                     37 |
|          2019 | Shopify  |                 178 |                    183 |
|          2020 | Retail   |                  41 |                     37 |
|          2020 | Shopify  |                 175 |                    179 |
+---------------+----------+---------------------+------------------------+