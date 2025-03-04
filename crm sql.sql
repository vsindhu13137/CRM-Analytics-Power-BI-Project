create database opportunity;
use opportunity;

#OPPORTUNITY---
---#Expected Amount
SELECT SUM(CAST(REPLACE(REPLACE(`expected Amount`, '$', ''), ',', '') AS DECIMAL(10, 2))) AS Expected_Amount FROM oppertuninty_table;
---#Active Opportunities 
SELECT COUNT(*) AS Active_Opportunities FROM oppertuninty_table WHERE Closed = 'FALSE';
---#Conversion Rate (%)
SELECT (SUM(CASE WHEN `Stage` = 'Closed Won' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Conversion_Rate FROM oppertuninty_table;
---#Win Rate (%)
SELECT (SUM(CASE WHEN `Stage` = 'Closed Won' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Win_Rate FROM oppertuninty_table;
---#Loss Rate (%)
SELECT (SUM(CASE WHEN `Stage` = 'Closed Lost' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Loss_Rate FROM oppertuninty_table;
---#Expected Vs Forecast
SELECT `Close Date`,SUM(CAST(REPLACE(REPLACE(`Amount`, '$', ''), ',', '') AS DECIMAL(10, 2))) OVER (ORDER BY `Close Date`) AS Running_Expected_Amount,
    SUM(CAST(REPLACE(REPLACE(`Expected Amount`, '$', ''), ',', '') AS DECIMAL(10, 2))) OVER (ORDER BY `Close Date`) AS Running_Forecast_Amount FROM oppertuninty_table ORDER BY `Close Date`;
---#Active Vs Total Opportunities
SELECT `Close Date`,SUM(CASE WHEN `Closed` = 'FALSE' THEN 1 ELSE 0 END) OVER (ORDER BY `Close Date`) AS Running_Active_Opportunities,COUNT(*) OVER (ORDER BY `Close Date`) AS Running_Total_Opportunities 
FROM oppertuninty_table ORDER BY `Close Date` ;
---#Closed Won Vs Total Opportunities
SELECT `Close Date`,SUM(CASE WHEN `Stage` = 'Closed Won' THEN 1 ELSE 0 END) OVER (ORDER BY `Close Date`) AS Running_Closed_Won,
    COUNT(*) OVER (ORDER BY `Close Date`) AS Running_Total_Opportunities FROM oppertuninty_table ORDER BY `Close Date`;
---#Closed Won Vs Total Closed
SELECT `Close Date`,SUM(CASE WHEN `Stage` = 'Closed Won' THEN 1 ELSE 0 END) OVER (ORDER BY `Close Date`) AS Running_Closed_Won,
    SUM(CASE WHEN `Closed` = 'TRUE' THEN 1 ELSE 0 END) OVER (ORDER BY `Close Date`) AS Running_Total_Closed FROM oppertuninty_table ORDER BY `Close Date`;
---#Expected Amount by Opportunity Type
SELECT `Opportunity Type`,SUM(CAST(REPLACE(REPLACE(`Amount`, '$', ''), ',', '') AS DECIMAL(10, 2))) AS Expected_Amount FROM oppertuninty_table GROUP BY `Opportunity Type`;
---# Opportunities by Industry
SELECT Industry, COUNT('Opportunity_ID') AS Total_Opportunities FROM oppertuninty_table GROUP BY Industry ORDER BY Total_Opportunities DESC;






----#LEAD
---#Total Lead
SELECT COUNT(*) AS Total_Leads FROM lead_table;
---# Expected Amount from Converted Leads 
SELECT SUM(CAST(REPLACE(REPLACE(`Amount`, '$', ''), ',', '') AS DECIMAL(10, 2))) AS Expected_Amount FROM oppertuninty_table
WHERE `Created by Lead Conversion` = 'TRUE';
---#Conversion Rate (%)
SELECT (SUM(`Converted` = 'TRUE') / COUNT(*)) * 100 AS Conversion_Rate FROM lead_table;
---# Converted Accounts
SELECT COUNT(DISTINCT `Converted Account ID`) AS Converted_Accounts FROM lead_table WHERE `Converted` = 'TRUE';
---#Converted Opportunities
SELECT COUNT(DISTINCT `Converted Opportunity ID`) AS Converted_Opportunities FROM lead_table WHERE `Converted` = 'TRUE';
---#Lead By Source
SELECT `Lead Source`,COUNT(*) AS Leads_Count FROM lead_table GROUP BY `Lead Source`;
---#Lead By industry
SELECT `Industry`,COUNT(*) AS Leads_Count FROM lead_table GROUP BY `Industry`;
---#Lead by Stage
SELECT `Status`,COUNT(*) AS Leads_Count FROM lead_table GROUP BY `Status`;


