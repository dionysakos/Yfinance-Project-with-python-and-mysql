DELETE FROM daily_prices WHERE ticker IN ('MSFT', 'GOOG', 'AMZN');
SELECT DISTINCT ticker FROM daily_prices;
SELECT ticker,AVG(high) AS average_high FROM daily_prices
GROUP BY ticker;
SELECT ticker,AVG(low) AS average_low FROM daily_prices
GROUP BY ticker;
SELECT ticker, MAX(volume) AS max_volume FROM daily_prices
GROUP BY  ticker
ORDER BY max_volume;
SELECT  DISTINCT bad.ticker, -- Select all tickers for which the opening price on the most recent date in the dataset exceeds the opening price on the earliest date of the same ticker.
bad.open AS first_price_open,bad.date AS first_date_open,
imp.open AS improved_price_open,imp.date AS improved_date_open
FROM daily_prices bad
JOIN daily_prices imp
ON bad.ticker = imp.ticker
WHERE bad.date = (
SELECT MIN(date) FROM daily_prices 
WHERE bad.ticker = ticker 
GROUP BY ticker)
AND imp.date = (
SELECT MAX(date) FROM daily_prices
WHERE imp.ticker=ticker
GROUP BY ticker)
AND bad.open < imp.open
ORDER BY bad.ticker;
SELECT ticker,date FROM daily_prices GROUP BY ticker,date;
SELECT ticker,MAX(daily_return) AS max_daily_return FROM (SELECT today.ticker,ROUND((today.close-yesterday.close)/yesterday.close,2) AS daily_return
FROM daily_prices today
JOIN daily_prices yesterday
ON DATEDIFF(today.date,yesterday.date)=1 AND today.ticker=yesterday.ticker) AS sb
GROUP BY ticker
ORDER BY max_daily_return ASC;
SELECT ticker,MIN(close),MAX(close) FROM daily_prices
GROUP BY ticker;
SELECT DISTINCT d.ticker,d.date
FROM daily_prices d
WHERE d.volume = (
SELECT MAX(volume) FROM daily_prices
WHERE d.ticker = ticker)
ORDER BY d.date;
SELECT DISTINCT d.ticker,d.date,d.open AS max_open
FROM daily_prices d
WHERE d.open = (
SELECT MAX(open)
FROM daily_prices
WHERE ticker = d.ticker
)
ORDER BY max_open DESC, date;
SELECT DISTINCT first.ticker,first.date AS first_date,first.volume AS first_volume,last.date AS last_date,last.volume AS last_volume, ROUND((last.volume - first.volume),2) AS volume_difference
FROM daily_prices first
JOIN daily_prices last
ON first.ticker = last.ticker 
WHERE first.date = (
SELECT MIN(date) FROM daily_prices
WHERE first.ticker = ticker)
AND last.date = (
SELECT MAX(date) FROM daily_prices
WHERE last.ticker = ticker)
ORDER BY volume_difference;





