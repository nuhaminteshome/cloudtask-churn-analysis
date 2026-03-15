-- 3. Revenue Trends
-- Plot monthly MRR over time.
-- Calculate net revenue retention (new MRR minus churned MRR). Identify months with unusual spikes or dips.

SELECT * 
FROM dbo.monthly_revenue;

SELECT monthly_revenue, churned
FROM dbo.subscriptions;

-- monthly MRR over time
SELECT month, total_mrr
FROM dbo.monthly_revenue;
-- new MRR
SELECT month, new_customers, avg_revenue_per_customer, (new_customers * avg_revenue_per_customer) AS new_MRR
FROM dbo.monthly_revenue;

-- churned MRR
SELECT month, churned_customers, avg_revenue_per_customer, (churned_customers * avg_revenue_per_customer) AS churned_MRR
FROM dbo.monthly_revenue;

-- net revenue change
SELECT month, ROUND((new_customers * avg_revenue_per_customer) - (churned_customers * avg_revenue_per_customer), 2) AS net_revenue_change
FROM dbo.monthly_revenue;
