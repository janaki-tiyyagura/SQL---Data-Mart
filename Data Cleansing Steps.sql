CREATE TABLE clean_weekly_sales AS
(
	SELECT 
    STR_TO_DATE(week_date,'%d/%m/%y') AS week_date,
    WEEK(STR_TO_DATE(week_date,'%d/%m/%y')) AS week_number,
    MONTH(STR_TO_DATE(week_date,'%d/%m/%y')) AS month_number,
    YEAR(STR_TO_DATE(week_date,'%d/%m/%y')) AS calender_year,
    region,
    platform,
    CASE 
		WHEN segment IS NULL THEN 'unknown' 
		WHEN segment = 'null' THEN 'unknown'
		ELSE segment
	END AS segment,
    CASE 
		WHEN right(segment,1) = '1' THEN 'Young Adults'
		WHEN right(segment,1) = '2' THEN 'Middle Aged'
        WHEN right(segment,1) IN ('3','4') THEN 'Retirees'
        ELSE 'unknown'
	END AS age_brand,
    CASE 
		WHEN LEFT(segment,1) = 'C' THEN 'Couples'
        WHEN LEFT(segment,1) = 'F' THEN 'Families'
        ELSE 'unknown'
	END AS demographic,
    customer_type,
    transactions,
    sales,
    ROUND(sales/transactions,2) AS avg_transactions
    FROM weekly_sales
);
    
    
    