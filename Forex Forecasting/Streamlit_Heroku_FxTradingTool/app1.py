import streamlit as st
import matplotlib.pyplot as plt
import warnings
warnings.filterwarnings('ignore')  # Hide warnings
import pandas as pd
pd.core.common.is_list_like = pd.api.types.is_list_like
import pandas_datareader.data as web
from datetime import datetime
import matplotlib.dates as mdates
import pandas as pd
from PIL import Image
import os
from mplfinance.original_flavor import candlestick_ohlc
import seaborn as sns
import fxcmpy

# Loads the data and show

st.title('Forex Market App')
'---------------------------------------------------------'
#text
st.write("Developed by Hai Binh")

image = Image.open(os.path.join('Technical-Analysis-in-Forex-Trading.jpg'))
st.image(image)

com = st.text_input("Enter the Forex Code of Money Exchanges","EUR/USD")

'You Enterted the company code: ', com

st_date= st.text_input("Enter Starting date as YYYY-MM-DD (from 2010-01-01)", "2010-01-01")

'You Enterted the starting date: ', st_date

end_date= st.text_input("Enter Ending date as YYYY-MM-DD (to 2020-11-01)", "2020-11-24")

'You Enterted the ending date: ', end_date

# Collects the data
TOKEN = 'ccf0e2248bf73ca5f37919cc53913fa67935cea4'
con = fxcmpy.fxcmpy(access_token=TOKEN, log_level='error', server='real')

df = con.get_candles(com, period='D1',start=st_date, stop=end_date,columns=['asks', 'tickqty'])
df.rename(columns = {'askopen':'open',
                       'askclose':'close',
                       'askhigh':'high',
                       'asklow':'low',
                       'tickqty':'volume'}, inplace = True)
#df = web.DataReader(com, "av-forex-daily", start=datetime.strptime(st_date, '%Y-%m-%d'), end=datetime.strptime(end_date,'%Y-%m-%d'),
                    #api_key='E5O5694NQEOWQFOR')  # Collects data
#title
st.title('Forex Market Data')

'The Complete Forex Data as extracted from Alpha Vantage: '
df

'1. The Forex Open Values over time: '
st.line_chart(df["open"])

'2. The Forex Close Values over time: '
st.line_chart(df["close"])

#title
st.title('Moving Averages')
'---------------------------------------------------------'
'Forex Data Based on Moving Averages'
'A moving average (MA) is a forex indicator that is commonly used in technical analysis.'
'The reason for calculating the moving average of a stock is to help smooth out the price data over a specified period of time by creating a constantly updated average price.'
'A simple moving average (SMA) is a calculation that takes the arithmetic mean of a given set of prices over the specific number of days in the past; for example, over the previous 15, 30, 100, or 200 days.'

mov_avg= st.text_input("Enter number of days Moving Average:", "50")

'You Enterted the Moving Average: ', mov_avg


df["mov_avg_close"] = df['close'].rolling(window=int(mov_avg),min_periods=0).mean()

'1. Plot of Forex Closing Value for '+ mov_avg+ " Days of Moving Average"
'   Actual Closing Value also Present'
st.line_chart(df[["mov_avg_close","close"]])

df["mov_avg_open"] = df['open'].rolling(window=int(mov_avg),min_periods=0).mean()

'2. Plot of Forex Open Value for '+ mov_avg+ " Days of Moving Average"
'   Actual Opening Value also Present'
st.line_chart(df[["mov_avg_open","open"]])



st.title("OHLC Candle Stick Graph")
'------------------------------------------------------------------------------------------'
'Candlestick charts are used by traders to determine possible price movement based on past patterns.'
'Candlesticks are useful when trading as they show four price points (open, close, high, and low) throughout the period of time the trader specifies.'
'Many algorithms are based on the same price information shown in candlestick charts.'
'Trading is often dictated by emotion, which can be read in candlestick charts.'

ohlc_day = st.text_input("Enter number of days for Resampling for OHLC CandleStick Chart", "50")

'You Enterted the Moving Average: ', ohlc_day

# Resample to get open-high-low-close (OHLC) on every n days of data
df_ohlc = df.close.resample(ohlc_day+'D').ohlc()
df_volume = df.volume.resample(ohlc_day+'D').sum()


# data.index = pd.to_datetime(data.index, unit='s')
df_ohlc.reset_index(inplace=True)
df_ohlc.date = df_ohlc.date.map(mdates.date2num)



# Create and visualize candlestick charts
plt.figure(figsize=(8,6))

'OHLC Candle Stick Graph for '+ ohlc_day+ " Days"

ax1 = plt.subplot2grid((6,1), (0,0), rowspan=5, colspan=1)
ax1.xaxis_date()
candlestick_ohlc(ax1, df_ohlc.values, width=2, colorup='g')
plt.xlabel('Time')
plt.ylabel('Forex Candle Sticks')
st.pyplot()

st.title("Note")
'------------------------------------------------------'
'All Forex data from Alpha Vantage'
'Accurately enter the stock code and date'
'Stock Prices in USD'
