### SQL Project: Exploring and Analyzing Financial Data
##1 Exploring the Dataset


1.1 First Few Rows

<pre>
-- Display the first few rows of the dataset
SELECT * FROM stocks27 ORDER BY symbol LIMIT 10;
</pre>

![Result](https://iili.io/Jzm8RkJ.jpg)


1.2 Summary Statistics for 'SYMBOL' Column

<pre>
SELECT
    COUNT(*) AS TotalRows,
    COUNT(SYMBOL) AS NonNullCount,
    COUNT(*) - COUNT(SYMBOL) AS MissingCount,
    (COUNT(SYMBOL) * 100.0) / COUNT(*) AS NonNullPercentage
FROM stocks.stocks27;
</pre>

![Result](https://iili.io/JzmQmI1.jpg)

1.3 Describing Table Structure

<pre>
-- Use the DESCRIBE statement to get a quick overview of the table structure
DESCRIBE stocks27;
</pre>

![Result](https://iili.io/Jzmyd4n.jpg)

1.4 Information Schema

<pre>
-- Calculate the average volume and the number of stocks for each sector
SELECT
    CASE WHEN Sector = '' THEN 'No specified' ELSE Sector END AS AdjustedSector,
    AVG(Volume) AS AverageVolume,
    COUNT(*) AS NumStocks
FROM stocks27
GROUP BY AdjustedSector;
</pre>


![Result](https://iili.io/Jzpd1Dv.jpg)

###2. Data Analysis

2.1 Average Volume and Number of Stocks by Sector

<pre>
-- Calculate the average volume and the number of stocks for each sector
SELECT
    CASE WHEN Sector = '' THEN 'No specified' ELSE Sector END AS AdjustedSector,
    AVG(Volume) AS AverageVolume,
    COUNT(*) AS NumStocks
FROM stocks27
GROUP BY AdjustedSector;
</pre>

![Result](https://iili.io/JzpFxNs.jpg)

2.2 Number of Stocks by Adjusted Security Type

<pre>
-- Calculate the number of stocks for each adjusted security type
SELECT
    CASE WHEN `Security Type` = '' THEN 'No specified' ELSE `Security Type` END AS AdjustedSecurityType,
    COUNT(*) AS NumStocks
FROM stocks27
GROUP BY AdjustedSecurityType;
</pre>

![Result](https://iili.io/JzpfzG4.jpg)

2.3 Analysis by 'S&P' Rating

<pre>
-- Calculate average volume and counts for each distinct 'S&P' rating
SELECT
    CASE WHEN TRIM(`S&P`) = '' THEN 'No specified' ELSE TRIM(`S&P`) END AS "S&P_Rating",
    AVG(Volume) AS AverageVolume,
    COUNT(*) AS NumStocks
FROM stocks27
GROUP BY TRIM(`S&P`);
</pre>

![Result](https://iili.io/JzpoWT7.jpg)


2.4 Analysis by 'S&P' Rating with Average Last(price)

<pre>
-- Calculate average 'Last' value for each 'S&P' rating, excluding values higher than 30
SELECT
    CASE WHEN TRIM(`S&P`) = '' THEN 'No specified' ELSE TRIM(`S&P`) END AS "S&P_Rating",
    ROUND(AVG(CASE WHEN `Last` <= 30 THEN `Last` ELSE NULL END), 2) AS AverageLast,
    AVG(Volume) AS AverageVolume,
    COUNT(*) AS NumStocks
FROM stocks27
GROUP BY TRIM(`S&P`)
HAVING AVG(CASE WHEN `Last` <= 30 THEN `Last` ELSE NULL END) IS NOT NULL;
</pre>

![Result](https://iili.io/JzpzNdx.jpg)

###3. Special Queries
3.1 Upcoming Ex-Dividend Dates

<pre>
-- Retrieve symbols and corresponding ex-dividend dates within the next 30 days
SELECT DISTINCT Symbol, `Ex-Dividend` AS ExDivDate
FROM stocks27
WHERE STR_TO_DATE(`Ex-Dividend`, '%a %b %d %Y') BETWEEN CURDATE() AND CURDATE() + INTERVAL 30 DAY
ORDER BY DAY(STR_TO_DATE(`Ex-Dividend`, '%a %b %d %Y'));
</pre>


![Result](https://iili.io/JzpTuFs.jpg)

3.2 High and Low HTB Availability

<pre>
-- Retrieve symbols and corresponding rounded HTB rates for high availability
SELECT Symbol, ROUND(`HTB Rate`, 2) AS RoundedHTBRate
FROM stocks27
WHERE `HTB Rate` > 50
ORDER BY `HTB Rate` DESC;

-- Retrieve symbols and corresponding rounded HTB rates for low availability
SELECT Symbol, ROUND(`HTB Rate`, 2) AS RoundedHTBRate
FROM stocks27
WHERE `HTB Rate` BETWEEN 0 AND 10
ORDER BY `HTB Rate` DESC;
</pre>

![Result](https://iili.io/Jzp5tI4.jpg)






































