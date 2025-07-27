--What is the total revenue generated per year and month?
 
SELECT 
EXTRACT(month FROM payment_date) AS Month,
EXTRACT(year FROM payment_date) AS Year,
SUM(amount) AS total_revenue FROM payment 
GROUP BY Month,Year
ORDER BY total_revenue DESC;


--Which staff member processed the most payments each month?

SELECT Year, Month, staff_id, first_name, last_name, total_revenue
FROM (
  SELECT 
    EXTRACT(year FROM payment_date) AS Year,
    EXTRACT(month FROM payment_date) AS Month,
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    SUM(amount) AS total_revenue,
    ROW_NUMBER() OVER (
      PARTITION BY EXTRACT(year FROM payment_date), EXTRACT(month FROM payment_date)
      ORDER BY SUM(amount) DESC
    ) AS rn
  FROM payment
  JOIN staff ON payment.staff_id = staff.staff_id
  GROUP BY 
    EXTRACT(year FROM payment_date), 
    EXTRACT(month FROM payment_date), 
    staff.staff_id, 
    staff.first_name, 
    staff.last_name
) AS sub
WHERE rn = 1
ORDER BY Year, Month;
