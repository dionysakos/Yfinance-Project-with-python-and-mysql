DELETE FROM daily_prices WHERE ticker IN ('MSFT', 'GOOG', 'AMZN');
SELECT DISTINCT ticker FROM daily_prices;
SELECT ticker,AVG(high) AS average_high FROM daily_prices
GROUP BY ticker;
SELECT ticker,AVG(low) AS average_low FROM daily_prices
GROUP BY ticker;
SELECT ticker, MAX(volume) AS max_volume FROM daily_prices
GROUP BY  ticker
ORDER BY max_volume;
SELECT 
