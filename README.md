### SQL Project: Exploring and Analyzing Financial Data

![Result](https://iili.io/JzyxFdx.jpg)

## 1 Exploring the Dataset


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

1.5 Checking for NON null values
<pre>
SELECT
    'Symbol' AS ColumnName,
    COUNT(*) AS TotalRows,
    COUNT(Symbol) AS NonNullCount,
    COUNT(*) - COUNT(Symbol) AS MissingCount,
    (COUNT(Symbol) * 100.0) / COUNT(*) AS NonNullPercentage
FROM stocks.stocks27
UNION
SELECT
    'Last' AS ColumnName,
    COUNT(*) AS TotalRows,
    COUNT(Last) AS NonNullCount,
    COUNT(*) - COUNT(Last) AS MissingCount,
    (COUNT(Last) * 100.0) / COUNT(*) AS NonNullPercentage
FROM stocks.stocks27
UNION
</pre>

![Result](https://iili.io/JzpwkKu.jpg)

### 2. Data Analysis

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

### 3. Special Queries
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


3.3 Stocks with extremly high HTB rate


<pre>
SELECT Symbol, ROUND(`HTB Rate`, 2) AS RoundedHTBRate ,`S&P`
FROM stocks27
WHERE `HTB Rate` > 50
ORDER BY `HTB Rate` DESC;
</pre>


![Result](https://iili.io/JzpVzVs.jpg)


3.4 Stocks with low HTB rate

<pre>
SELECT Symbol, ROUND(`HTB Rate`, 2) AS RoundedHTBRate
FROM stocks27
WHERE `HTB Rate` BETWEEN 0 AND 10
ORDER BY `HTB Rate` DESC;
</pre>

![Result](https://iili.io/JzpXWAB.jpg)




3.5 Stocks with Maturity in Next 2 Years and Last(price)

<pre>
-- Retrieve symbols, modified maturity dates, and 'Last' values for stocks with maturity in the next 2 years
SELECT Symbol, SUBSTRING(`Maturity Date`, 5) AS ModifiedMaturityDate, Last
FROM stocks27
WHERE STR_TO_DATE(SUBSTRING(`Maturity Date`, 5), '%b %d %Y') >= CURDATE()
  AND STR_TO_DATE(SUBSTRING(`Maturity Date`, 5), '%b %d %Y') <= CURDATE() + INTERVAL 2 YEAR
ORDER BY ABS(DATEDIFF(STR_TO_DATE(SUBSTRING(`Maturity Date`, 5), '%b %d %Y'), CURDATE()))
LIMIT 0, 300;
</pre>


![Result](https://iili.io/Jzpl4J1.jpg)




## Project Summary
# Project Goals and Achievements

The SQL project aimed to explore and analyze financial data within the 'stocks27' dataset. The key goals were:

    Data Exploration:
        Utilized SQL queries to display the first few rows of the dataset and provide summary statistics for the 'SYMBOL' column.
        Employed the INFORMATION_SCHEMA to obtain detailed information about the table structure.

    Data Analysis:
        Conducted sector-wise analysis by calculating the average volume and the number of stocks for each sector.
        Examined the distribution of stocks based on adjusted security types.
        Investigated trends in the dataset by analyzing the average volume and stock counts for distinct 'S&P' ratings.
        Further analyzed 'S&P' ratings, excluding values above 30, to observe their impact on average 'Last' values.

    Special Queries:
        Identified upcoming ex-dividend dates within the next 30 days, providing symbols and corresponding dates.
        Explored stocks with high and low Hard-to-Borrow (HTB) availability, showcasing symbols and rounded HTB rates.
        Investigated stocks with maturities in the next 2 years, retrieving symbols, modified maturity dates, and 'Last' values.

        




 ## In summary, the project accomplished its objectives by providing a thorough exploration of the dataset, conducting insightful analyses, and addressing specific financial scenarios through specialized queries. The results obtained offer valuable insights for stakeholders in the financial domain.




















