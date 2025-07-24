import mysql.connector
import yfinance as yf

conn = mysql.connector.connect(
    host="localhost",
    user="root",  
    password="Dennisk2005!",  
    database="stock_data"  
)
cursor = conn.cursor()


tickers = ['AAPL', 'NVDA', 'TSLA']


for ticker in tickers:
    print(f"Fetching data for {ticker}...")
    stock_data = yf.download(ticker, period='1y', interval='1d')
    for index, row in stock_data.iterrows():
        values = (
            index.strftime('%Y-%m-%d'),  
            float(row['Close']),        
            float(row['High']),          
            float(row['Low']),           
            float(row['Open']),          
            int(row['Volume']),         
            ticker                      
        )  
        # Insert the data into the database
        insert_query = """
            INSERT INTO daily_prices (date, close, high, low, open, volume, ticker)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        
        try:
            cursor.execute(insert_query, values)
            conn.commit()
        except mysql.connector.Error as e:
            print(f"Error inserting data for {ticker} on {index.strftime('%Y-%m-%d')}: {e}")
    
    print(f"Data for {ticker} inserted successfully!")

# Close the cursor and connection
cursor.close()
conn.close()
