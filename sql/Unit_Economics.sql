-- 3. Unit Economics
-- Compute average CLV per plan using average MRR and average customer lifespan.
-- Compare CLV to CAC to determine the CLV:CAC ratio.

SELECT *
FROM dbo.subscriptions;

SELECT * 
FROM dbo.monthly_revenue;

-- average MRR by plan
SELECT [plan], ROUND(AVG(monthly_revenue), 2) AS avg_MRR
FROM dbo.subscriptions
GROUP BY [plan]
ORDER BY avg_MRR DESC;

-- average customer lifespan per plan (only for the churned customers)

SELECT [plan], AVG(DATEDIFF(month, signup_date, ISNULL(churn_date, GETDATE()))) AS avg_customer_lifespan_in_months
FROM dbo.subscriptions
GROUP BY [plan];


-- average CLV per plan
SELECT [plan], AVG(monthly_revenue) AS avg_mrr, AVG(DATEDIFF(month, signup_date, churn_date)) AS avg_lifespan,
        AVG(monthly_revenue) * AVG(DATEDIFF(month, signup_date, churn_date)) AS avg_clv
FROM dbo.subscriptions
WHERE churned = 1
GROUP BY [plan];


-- average CAC per plan

SELECT ROUND(AVG(customer_acquisition_cost), 2) AS avg_cac
FROM dbo.monthly_revenue
WHERE customer_acquisition_cost > 0

-- CLV/CAC ratio

WITH 
	clv AS (
		SELECT 
			[plan],
			AVG(monthly_revenue) AS avg_mrr,
			AVG(DATEDIFF(month, signup_date, churn_date)) AS avg_lifespan,
			AVG(monthly_revenue) * AVG(DATEDIFF(month, signup_date, churn_date)) AS avg_clv
		FROM dbo.subscriptions
		WHERE churned = 1
		GROUP BY [plan]),
	cac AS (
		SELECT ROUND(AVG(customer_acquisition_cost), 2) AS avg_cac
		FROM dbo.monthly_revenue
		WHERE customer_acquisition_cost > 0)

SELECT 
    c1.[plan], 
    avg_clv, 
    avg_cac,
    ROUND(avg_clv / avg_cac, 2) AS clv_cac_ratio
FROM clv c1
CROSS JOIN cac
ORDER BY clv_cac_ratio DESC;






