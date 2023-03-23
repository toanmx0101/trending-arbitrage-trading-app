# Trending. Arbitrage Trading Program

Tôi bắt đầu với ý tưởng giá trị của các cặp tiền tệ trên các sàn giao dịch là khác nhau vì giá cả sẽ dựa trên cung cầu khác nhau giữa các thị trường và nền văn hoá. Bản thân tôi cũng đã trải qua việc chênh lệch giá này, nó xảy ra khi thị trường crypto bị đóng cửa ở trung quốc, khi đó tôi đang trade trên sàn Coinbene và Mexc. Giá của một vài cặp tiền tệ chênh khá nhiều từ 10 đến 20% giữa 2 sàn, khi đó tôi đã mua coin ở Mexc và bán sang Coinbene và kiếm được 1 khoản khá lơn.

Tôi tin điều này xảy ra không thường xuyên nhưng khi nó xảy ra, sẽ có 1 khoảng giá chênh rất lớn và điều này sẽ tạo cơ hội cho nhiều người, nhiều cá nhân có thể mua bán kiếm tiền dựa trên sự chênh lệch này, 

Việc này càng thôi thúc tôi tạo ra một tool, ứng dụng để có thể phát hiện sự chênh lệch giá giữa của cặp tiền tệ trên các sàn giao dịch khác nhau

### Các đinh nghĩa về giao dịch chênh lệch giá

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

Day 1

Tôi lên ý tưởng và cóp nhặt những phần đã làm từ trước các thư viện…

Tưởng tượng về ứng dụng của tôi sẽ có các chức năng sau:

- Liệt kê tên tất cả các coin trên các sàn giao dịch
- Liệt kê tất cả các sàn giao dịch
- Liệt kê các coin + cặp tiền tệ đi kèm trên sàn giao dịch
- Form tạo cặp tiền tệ giao dịch trên 2 sàn khác nhau
    - Lựa chọn cặp tiền tệ có cùng 1 coin trên 2 sàn khác nhau
    - Lựa chọn thời gian pull dữ liệu 1 phút/5 phút 15 phút…
    - Setting chanel Tele gửi thông tin về khi có sự chênh lệch
    - HIển thị giá của cặp tiền tệ trên 2 sàn được so sánh
    - HIển thị giá bid, giá ask, lợi nhuận trên 1000$ bỏ ra.
- Quản lý danh sách các cặp tiền tệ đã tạo (Thêm sửa xoá)
    - Sửa tên
    - Chỉnh sửa channel
    - Hiển thị giá cặp tiền tệ trên 2 sàn được so sánh
    - Hiển thị giá bid, ask
    - Hiển thị lợi nhuận trên 1000$ bỏ ra
- Liệt kê các coin đang trending 24h, 72h, 1 Tuần
    - Liêt kê các coin đang trending, bao gồm tên,cặp tiền tệ, volumn 24h

Tôi thiết kế db bao gồm các table sau

- exchange: lưu trữ thông tin các sàn giao dịch, title, description base API endpoint
- ticker: các cặp tiền tệ giao dịch thuộc về 1 sàn giao dịch nào đó (BTC_USDT)
- currency: các tiền tệ giao dịch trên tất cả các sàn (BTC)
- ticker_pair: so sánh 1 cặp tiền tệ giữa các sàn giao dịch