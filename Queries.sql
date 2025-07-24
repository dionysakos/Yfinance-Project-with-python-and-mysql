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


