-- First few rows
SELECT * FROM stocks27 ORDER BY  symbol LIMIT 10;


SELECT 
    COUNT(*) AS TotalRows,
    COUNT(SYMBOL) AS NonNullCount,
    COUNT(*) - COUNT(SYMBOL) AS MissingCount,
    (COUNT(SYMBOL) * 100.0) / COUNT(*) AS NonNullPercentage
FROM stocks.stocks27;



SELECT
    CASE WHEN Sector = '' THEN 'No specified' ELSE Sector END AS AdjustedSector,
    AVG(Volume) AS AverageVolume,
    COUNT(*) AS NumStocks
FROM stocks27
GROUP BY AdjustedSector;



SELECT DISTINCT `S&P`
FROM stocks27;

SELECT
    CASE WHEN TRIM(`S&P`) = '' THEN 'No specified' ELSE TRIM(`S&P`) END AS "S&P_Rating",
    AVG(Volume) AS AverageVolume,
    COUNT(*) AS NumStocks
FROM stocks27
GROUP BY TRIM(`S&P`);

SELECT
    CASE WHEN TRIM(`S&P`) = '' THEN 'No specified' ELSE TRIM(`S&P`) END AS "S&P_Rating",
    ROUND(AVG(CASE WHEN `Last` <= 30 THEN `Last` ELSE NULL END), 2) AS AverageLast,
    AVG(Volume) AS AverageVolume,
    COUNT(*) AS NumStocks
FROM stocks27
GROUP BY TRIM(`S&P`)
HAVING AVG(CASE WHEN `Last` <= 30 THEN `Last` ELSE NULL END) IS NOT NULL;

SELECT DISTINCT Symbol, `Ex-Dividend` AS ExDivDate
FROM stocks27
WHERE STR_TO_DATE(`Ex-Dividend`, '%a %b %d %Y') BETWEEN CURDATE() AND CURDATE() + INTERVAL 30 DAY
ORDER BY DAY(STR_TO_DATE(`Ex-Dividend`, '%a %b %d %Y'));


SELECT Symbol, ROUND(`HTB Rate`, 2) AS RoundedHTBRate
FROM stocks27
WHERE `HTB Rate` BETWEEN 0 AND 10
ORDER BY `HTB Rate` DESC;



SELECT Symbol, `HTB Avaiability`
FROM stocks27
ORDER BY `HTB Avaiability` ASC
LIMIT 50;

SELECT Symbol, `HTB Avaiability`
FROM stocks27
ORDER BY `HTB Avaiability` DESC
limit 50;

SELECT Symbol, SUBSTRING(`Maturity Date`, 5) AS ModifiedMaturityDate,Last,`S&P`
FROM stocks27
WHERE STR_TO_DATE(SUBSTRING(`Maturity Date`, 5), '%b %d %Y') >= CURDATE()
  AND STR_TO_DATE(SUBSTRING(`Maturity Date`, 5), '%b %d %Y') <= CURDATE() + INTERVAL 2 YEAR
ORDER BY ABS(DATEDIFF(STR_TO_DATE(SUBSTRING(`Maturity Date`, 5), '%b %d %Y'), CURDATE()))
LIMIT 0, 300;

SELECT Symbol, ROUND(`HTB Rate`, 2) AS RoundedHTBRate ,`S&P`
FROM stocks27
WHERE `HTB Rate` > 50
ORDER BY `HTB Rate` DESC;

SELECT Symbol, ROUND(`HTB Rate`, 2) AS RoundedHTBRate,`S&P`,`Last`
FROM stocks27
WHERE `HTB Rate` BETWEEN 0 AND 10
ORDER BY `HTB Rate` ASC;



