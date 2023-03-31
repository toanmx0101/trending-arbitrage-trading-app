# Trending. Arbitrage Trading Program

I start with the idea that the value of currency pairs on exchanges is different because pricing will be based on supply and demand which varies across markets and cultures. I myself experienced this arbitrage, it happened when the crypto market was closed in China, when I was trading on Coinbene and Mex. The prices of some currency pairs differed quite a bit from 10 to 20% between the two exchanges, then I bought coins in Mex and sold them to Coinbene and made a pretty large amount.

I believe this happens infrequently but when it does, there will be a huge spread and this will create an opportunity for many people, many individuals to be able to trade and make money based on this difference,

This motivated me to create a tool, an application that can detect the price difference between currency pairs on different exchanges. 

Việc này càng thôi thúc tôi tạo ra một tool, ứng dụng để có thể phát hiện sự chênh lệch giá giữa của cặp tiền tệ trên các sàn giao dịch khác nhau

### Arbitrage Concepts

[Arbitrage Trading Program (ATP)](https://www.investopedia.com/terms/a/atp.asp)

### How to build an arbitrage trading program? (ChatGPT)

Building an arbitrage trading program between crypto exchanges involves several steps, including:

1. Identifying the exchanges: The first step is to identify the crypto exchanges that you want to trade on. You'll want to choose exchanges that have high liquidity and low trading fees, as these are key factors for successful arbitrage trading.
2. Finding arbitrage opportunities: Once you have identified the exchanges, you will need to look for price differences between them for the same cryptocurrency. This can be done by monitoring the prices of the cryptocurrency across multiple exchanges.
3. Calculating potential profits: Once you've identified an arbitrage opportunity, you will need to calculate the potential profit. This involves taking into account the fees charged by each exchange, as well as any other costs such as transfer fees.
4. Building a trading bot: To execute trades quickly and efficiently, you will need to build a trading bot that can automatically place trades when the arbitrage opportunity arises. You can use programming languages such as Python, C++, or Java to build the bot.
5. Testing and refining: Once you have built the trading bot, you will need to test it thoroughly to ensure that it is working as expected. You should also monitor its performance and make any necessary adjustments to improve its effectiveness.
6. Ensuring compliance: Finally, it's important to ensure that your trading bot is compliant with any relevant regulations and laws. This may include registering as a financial services provider and complying with anti-money laundering (AML) and know-your-customer (KYC) requirements.

It's worth noting that building an arbitrage trading program is a complex process that requires a solid understanding of programming, finance, and trading. If you don't have the necessary skills or experience, it may be best to seek out the help of a professional or use a pre-built trading bot.

# First though

I came up with ideas and collected parts that were made before the libraries…

Imagine my application would have the following functions:

- List all coins on exchanges
- List all exchanges
- List coins + currency pairs included on the exchange
- Form to create currency pairs to trade on 2 different exchanges
     - Select currency pairs with the same coin on 2 different exchanges
     - Select data pull time 1 minute / 5 minutes 15 minutes...
     - Setting channel Tele sends information when there is a difference
     - Display the price of currency pairs on 2 compared exchanges
     - Display bid price, ask price, profit over $1000 spent.
- Manage the list of created currency pairs (Add, edit)
     - Edit name
     - Edit channel
     - Display currency pair prices on 2 compared exchanges
     - Display bid, ask
     - Show profit over 1000$ spent
- List coins that are trending 24h, 72h, 1 Week
     - List trending coins, including names, currency pairs, 24h volumn

I designed the db including the following tables

- exchange: store information about exchanges, title, description base API endpoint
- ticker: trading currency pairs belonging to a certain exchange (BTC_USDT)
- currency: currencies traded on all exchanges (BTC)
- ticker_pair: compare 1 currency pair between exchanges
