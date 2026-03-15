-- 2. Churn Analysis
--- Calculate churn rate by plan, billing cycle, acquisition channel, and company size.
--- Identify the highest-risk segments.

SELECT *
FROM dbo.subscriptions;

SELECT * 
FROM dbo.monthly_revenue;

-- overrall churn rate
SELECT (SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 1.0/COUNT(*)) * 100 AS Churn_Rate
FROM dbo.subscriptions;

SELECT month, monthly_churn_rate_pct
FROM dbo.monthly_revenue;

-- by plan
SELECT [plan], (SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 1.0/COUNT(*)) * 100 AS Churn_Rate
FROM dbo.subscriptions
GROUP BY [plan]
ORDER BY Churn_Rate DESC;

-- by billing cycle
SELECT billing_cycle, (SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 1.0/COUNT(*)) * 100 AS Churn_Rate
from dbo.subscriptions
GROUP BY billing_cycle
ORDER BY Churn_Rate DESC;

-- by acquisition channel
SELECT acquisition_channel, (SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 1.0/COUNT(*)) * 100 AS Churn_Rate
from dbo.subscriptions
GROUP BY acquisition_channel
ORDER BY Churn_Rate DESC;

-- by company size
SELECT company_size, (SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) * 1.0/COUNT(*)) * 100 AS Churn_Rate
from dbo.subscriptions
GROUP BY company_size
ORDER BY Churn_Rate DESC;
