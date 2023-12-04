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

![Result](https://notebook.zoho.eu/api/v1/notebooks/cuttqa2bf24e45a2d41119564c377aaeee4d5/notecards/ebqns8e7c2a7c347948358d4396df364de618/resources/ebqnse920a225a27d44d98e5baaed27b54718)
