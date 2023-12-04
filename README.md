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





