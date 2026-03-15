--4. At-Risk Indicators
-- Analyze the relationship between feature usage, NPS, and churn.
-- Define a threshold (e.g., feature usage below X%) that flags at-risk customers, and estimate how many current customers fall into that bucket.

SELECT *
FROM dbo.subscriptions;

SELECT  
       CASE 
            WHEN feature_usage_pct < 30 THEN 'Low'
            WHEN feature_usage_pct BETWEEN 30 AND 70 THEN 'Medium'
            ELSE 'High'
       END AS feature_usage_group, AVG(nps_score) AS avg_nps_score, COUNT(*) AS total_customers,
    SUM(CAST(churned AS INT)) AS total_churned
FROM dbo.subscriptions
GROUP BY
    CASE 
        WHEN feature_usage_pct < 30 THEN 'Low'
        WHEN feature_usage_pct BETWEEN 30 AND 70 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY total_churned;

-- based on the analysis above, customers who have a feature usage below 30% are considered at-risk customers

-- threshold : below 30%

SELECT customer_id, feature_usage_pct
FROM dbo.subscriptions
WHERE feature_usage_pct < 30 AND churned = 0;

SELECT COUNT(customer_id) AS count_at_risk_customers, [plan]
FROM dbo.subscriptions
WHERE feature_usage_pct < 30 AND churned = 0
GROUP BY [plan];

-- 42 current customers are at-risk
