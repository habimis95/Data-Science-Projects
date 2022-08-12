import warnings
warnings.filterwarnings('ignore')  # Hide warnings
from datetime import datetime
import pandas as pd
pd.core.common.is_list_like = pd.api.types.is_list_like
import pandas_datareader.data as web
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from PIL import Image
import os

from mplfinance.original_flavor import candlestick_ohlc
import matplotlib.dates as mdates
import streamlit as st
#import fxcmpy


#Importing Libraries done

#title
st.title('Stock Market App')
'---------------------------------------------------------'
#text
st.write("Developed by Hai Binh")

image = Image.open(os.path.join('Technical-Analysis-in-Forex-Trading.jpg'))
st.image(image)

com = st.text_input("Enter the Forex Code of Money Exchanges","EUR/USD")

'You Enterted the company code: ', com

st_date= st.text_input("Enter Starting date as YYYY-MM-DD (from 2010-01-01)", "2010-01-01")

'You Enterted the starting date: ', st_date

end_date= st.text_input("Enter Ending date as YYYY-MM-DD (to 2020-11-01)", "2020-11-01")

'You Enterted the ending date: ', end_date

# Collects the data
#TOKEN = 'ccf0e2248bf73ca5f37919cc53913fa67935cea4'
#con = fxcmpy.fxcmpy(access_token=TOKEN, log_level='error', server='real')

#df = con.get_candles(com, period='D1',start=st_date, stop=end_date,columns=['asks', 'tickqty'])
df = web.DataReader(com, "av-forex-daily", start=datetime.strptime(st_date, '%Y-%m-%d'), end=datetime.strptime(end_date,'%Y-%m-%d'),
                    api_key='E5O5694NQEOWQFOR')  # Collects data
#df.reset_index(inplace=True)
#df.set_index("Date", inplace=True)

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


df["mov_avg_close"] = df['Close'].rolling(window=int(mov_avg),min_periods=0).mean()

'1. Plot of Stock Closing Value for '+ mov_avg+ " Days of Moving Average"
'   Actual Closing Value also Present'
st.line_chart(df[["mov_avg_close","Close"]])

df["mov_avg_open"] = df['Open'].rolling(window=int(mov_avg),min_periods=0).mean()

'2. Plot of Stock Open Value for '+ mov_avg+ " Days of Moving Average"
'   Actual Opening Value also Present'
st.line_chart(df[["mov_avg_open","Open"]])



st.title("OHLC Candle Stick Graph")
'------------------------------------------------------------------------------------------'
'Candlestick charts are used by traders to determine possible price movement based on past patterns.'
'Candlesticks are useful when trading as they show four price points (open, close, high, and low) throughout the period of time the trader specifies.'
'Many algorithms are based on the same price information shown in candlestick charts.'
'Trading is often dictated by emotion, which can be read in candlestick charts.'

ohlc_day= st.text_input("Enter number of days for Resampling for OHLC CandleStick Chart", "50")

'You Enterted the Moving Average: ', ohlc_day

# Resample to get open-high-low-close (OHLC) on every n days of data
df_ohlc = df.close.resample(ohlc_day+'D').ohlc()
df_volume = df.volume.resample(ohlc_day+'D').sum()



df_ohlc.reset_index(inplace=True)
df_ohlc.Date = df_ohlc.Date.map(mdates.date2num)



# Create and visualize candlestick charts
plt.figure(figsize=(8,6))

'OHLC Candle Stick Graph for '+ ohlc_day+ " Days"

ax1 = plt.subplot2grid((6,1), (0,0), rowspan=5, colspan=1)
ax1.xaxis_date()
candlestick_ohlc(ax1, df_ohlc.values, width=2, colorup='g')
plt.xlabel('Time')
plt.ylabel('Stock Candle Sticks')
st.pyplot()

st.title("Note")
'------------------------------------------------------'
'All Stock data from Yahoo Finance'
'Accurately enter the stock code and date'
'Stock Prices in USD'

'LSTM'
data = pd.DataFrame(df.close)
dataset = data.values
training_data_len = math.ceil(len(dataset)*0.8)
test = data[training_data_len:]
#scaling
from sklearn.preprocessing import MinMaxScaler
scaler = MinMaxScaler(feature_range=(0,1))
scaled_data = scaler.fit_transform(dataset)

train_data = scaled_data[0:training_data_len,:]
x_train  = []
y_train  = []
for i in range(60, len(train_data)):
  x_train.append(train_data[i-60:i,0])
  y_train.append(train_data[i,0])

valid_data = scaled_data[training_data_len:,:]
x_valid  = []
y_valid  = []
for i in range(60, len(valid_data)):
  x_valid.append(valid_data[i-60:i,0])
  y_valid.append(valid_data[i,0])

x_train, y_train = np.array(x_train), np.array(y_train)
x_valid, y_valid = np.array(x_valid), np.array(y_valid)

# reshape to 3 dimension for LSTM
x_train = np.reshape(x_train, (x_train.shape[0], x_train.shape[1],1))

x_valid = np.reshape(x_valid, (x_valid.shape[0], x_valid.shape[1],1))

#LSTM
from keras.models import Sequential
from keras.layers import Dense, LSTM, Dropout
model = Sequential()
model.add(LSTM(50, return_sequences=True, input_shape=(x_train.shape[1],1)))
model.add(LSTM(50, return_sequences=False))
model.add(Dropout(0.2))
model.add(Dense(1, activation='relu'))

from keras.callbacks import EarlyStopping
from tensorflow.keras.optimizers import Adam
early_stop = EarlyStopping(monitor='loss', patience=10, verbose=1)
model.compile(loss='mean_squared_error', optimizer='adam')

history = model.fit(
    x_train, y_train,
    validation_data = (x_valid, y_valid),
    epochs = 200,
    batch_size=8,
    verbose=1,
    shuffle=False,
    callbacks=[early_stop]
)

plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.title('model loss')
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train', 'test'])

train = df[:training_data_len]
valid = df[training_data_len:]
valid['Predictions'] = predictions

plt.figure(figsize=(16,8))
plt.title('LSTM')
plt.xlabel('Date', fontsize=18)
plt.ylabel('Close Price VNĐ(đ)', fontsize=18)
plt.plot(train['close'])
plt.plot(valid[['close', 'Predictions']])
plt.legend(['Train', 'Validation', 'Predictions'], loc='upper left')
