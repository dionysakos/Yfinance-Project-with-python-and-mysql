import yfinance as yf
import pandas as pd

# List of tickers to fetch data for
tickers = ['AAPL', 'NVDA', 'TSLA']

# Define the date range for the stock data
start_date = '2022-01-01'
end_date = '2024-12-31'

# Loop through each ticker to download and save its data
for ticker in tickers:
    data = yf.download(ticker, start=start_date, end=end_date)
    
    # Reset the index (so the date becomes a column instead of an index)
    data.reset_index(inplace=True)
    
    # Add the 'Ticker' column to identify the stock
    data['Ticker'] = ticker  
    
    # Save the data to a CSV file
    filename = f"{ticker}_data.csv"
    data.to_csv(filename, index=False)
    
    # Print a message indicating the file has been saved
    print(f"Saved: {filename}")
