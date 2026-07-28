CREATE DATABASE CyberSecurityDB;
USE CyberSecurityDB;


CREATE TABLE global_cybersecurity (
    Country VARCHAR(50),
    Year INT,
    Attack_Type VARCHAR(100),
    Target_Industry VARCHAR(100),
    Financial_Loss_Million DECIMAL(10,2),
    Affected_Users INT,
    Attack_Source VARCHAR(100),
    Vulnerability_Type VARCHAR(100),
    Defense_Mechanism VARCHAR(100),
    Resolution_Time_Hours INT
);


-- Checking Null values if exist--
SELECT
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Null_Country,
    SUM(CASE WHEN Year IS NULL THEN 1 ELSE 0 END) AS Null_Year,
    SUM(CASE WHEN Attack_Type IS NULL THEN 1 ELSE 0 END) AS Null_Attack,
    SUM(CASE WHEN Financial_Loss_Million IS NULL THEN 1 ELSE 0 END) AS Null_Loss
FROM global_cybersecurity;

-- Checking Duplicacy in the data
SELECT *,
COUNT(*) AS duplicate_count
FROM global_cybersecurity
GROUP BY
Country,
Year,
Attack_Type,
Target_Industry,
Financial_Loss_Million,
Attack_Source,
Vulnerability_Type,
Affected_Users,
Defense_Mechanism,
Resolution_Time_Hours
HAVING COUNT(*) > 1;


-- Chcecking Negative Values
SELECT *
FROM global_cybersecurity
WHERE Financial_Loss_Million < 0
OR Affected_Users < 0
OR Resolution_Time_Hours < 0;


-- Adding New column for Resolution speed--
ALTER TABLE global_cybersecurity
ADD Resolution_Speed VARCHAR(20);

UPDATE global_cybersecurity
SET Resolution_Speed =
CASE
    WHEN Resolution_Time_Hours <= 12 THEN 'Fast'
    WHEN Resolution_Time_Hours <= 36 THEN 'Moderate'
    ELSE 'Slow'
END;

SELECT * FROM global_cybersecurity Limit 10;

-- Severity Level of Attacks in Millions
ALTER TABLE global_cybersecurity
ADD Severity_Level VARCHAR(20);

UPDATE global_cybersecurity
SET Severity_Level =
CASE
    WHEN Financial_Loss_Million >= 75 THEN 'Critical'
    WHEN Financial_Loss_Million >= 50 THEN 'High'
    WHEN Financial_Loss_Million >= 25 THEN 'Medium'
    ELSE 'Low'
END;


-- Attack Imapct Score
ALTER TABLE global_cybersecurity
ADD Attack_Impact_Score DECIMAL(10,2);

UPDATE global_cybersecurity
SET Attack_Impact_Score =
(
    Financial_Loss_Million * 0.5
    +
    (Affected_Users / 100000.0) * 0.3
    +
    Resolution_Time_Hours * 0.2
);


-- Cyber Risk Score
ALTER TABLE global_cybersecurity
ADD Cyber_Risk_Score DECIMAL(10,2);

UPDATE global_cybersecurity
SET Cyber_Risk_Score =
(
    Financial_Loss_Million * 0.4
    +
    (Affected_Users / 100000.0) * 0.4
    +
    Resolution_Time_Hours * 0.2
);


-- Financial Damage Category:- defining at what level damage has been done 
ALTER TABLE global_cybersecurity
ADD Damage_Category VARCHAR(20);

UPDATE global_cybersecurity
SET Damage_Category =
CASE
    WHEN Financial_Loss_Million >= 80 THEN 'Extreme Loss'
    WHEN Financial_Loss_Million >= 50 THEN 'Major Loss'
    WHEN Financial_Loss_Million >= 25 THEN 'Moderate Loss'
    ELSE 'Minor Loss'
END;


-- User Impact Category:- Based on the population level it had been attacked
ALTER TABLE global_cybersecurity
ADD User_Impact_Category VARCHAR(20);

UPDATE global_cybersecurity
SET User_Impact_Category =
CASE
	WHEN Affected_Users >= 800000 THEN 'Massive'
    WHEN Affected_Users >= 500000 THEN 'High'
    WHEN Affected_Users >= 200000 THEN 'Medium'
    ELSE 'Low'
END;

SELECT * FROM global_cybersecurity Limit 10;


-- Year Grouping
ALTER TABLE global_cybersecurity
ADD Year_Group VARCHAR(20);

UPDATE global_cybersecurity
SET Year_Group =
CASE
    WHEN Year BETWEEN 2015 AND 2017 THEN '2015-2017'
    WHEN Year BETWEEN 2018 AND 2020 THEN '2018-2020'
    ELSE '2021-2024'
END;


-- Defence Effectiveness regarding the resolution
ALTER TABLE global_cybersecurity
ADD Defense_Effectiveness VARCHAR(30);

UPDATE global_cybersecurity
SET Defense_Effectiveness =
CASE
    WHEN Resolution_Time_Hours <= 24 THEN 'Highly Effective'
    WHEN Resolution_Time_Hours <= 48 THEN 'Moderately Effective'
    ELSE 'Needs Improvement'
END;













































































































































































