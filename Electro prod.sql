use supardb;

select * from all_data;

select count(*) from all_data;


DESCRIBE all_data;

SET SQL_SAFE_UPDATES = 0;

# IDENTIFY THE BEST MONTH FOR SALES:

SELECT 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y %H:%i'), '%Y-%m') AS month, 
    SUM(`Quantity Ordered` * `Price Each`) AS total_sales
FROM 
    all_data
GROUP BY 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y %H:%i'), '%Y-%m')
ORDER BY 
    total_sales DESC
LIMIT 1;

# TO CALCULATE TOTAL EARINGS:

SELECT 
    SUM(`Quantity Ordered` * `Price Each`) AS total_earnings
FROM 
    all_data;
    
# To calculate both the best month for sales and the total earnings

SELECT 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y %H:%i'), '%Y-%m') AS best_month,
    SUM(`Quantity Ordered` * `Price Each`) AS total_sales,
    (SELECT SUM(`Quantity Ordered` * `Price Each`) FROM all_data) AS total_earnings
FROM 
    all_data
GROUP BY 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y %H:%i'), '%Y-%m')
ORDER BY 
    total_sales DESC
LIMIT 1;






