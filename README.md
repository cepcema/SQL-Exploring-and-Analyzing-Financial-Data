### SQL Project: Exploring and Analyzing Financial Data
##1. Exploring the Dataset


1.1 Exploring the Dataset

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
