module Exchanges
  class Bitfinex < BaseExchange
    API_ENDPOINT = "https://api.bithumb.com"
    SYMBOLS_URL = "https://api-pub.bitfinex.com/v2/tickers"
    TICKET_URL = "#{API_ENDPOINT}/public/ticker"

    def symbols
      response = HttpAbstractor.get(SYMBOLS_URL)
      response.body["data"]["tickers"]
              .select {|pair| pair["symbol"].end_with?("_USDT") && pair["quote_volume_24h"].to_f > 20000}
              .map{ |pair| pair["symbol"].gsub("_USDT", "") }
    end

    def price(coin_name)
    end
  end
end