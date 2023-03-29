module Exchanges
  class Lbank < BaseExchange
    API_ENDPOINT = "https://api.lbkex.com/v2"
    SYMBOLS_URL = "#{API_ENDPOINT}/currencyPairs.do"
    TICKER_URL = "#{API_ENDPOINT}/ticker.do"

    def price(coin_name)
      response = HttpAbstractor.get(TICKER_URL, { symbol: symbol(coin_name)})
      response.body["data"].first["ticker"]["latest"].to_f
    end

    def symbols
      response = HttpAbstractor.get(SYMBOLS_URL)
      response.body.select do |pair|
        pair.include?("_usdt")
      end.map do |pair|
        pair.gsub?("_usdt", "")
      end
    end

    def symbol(coin_name)
      "#{coin_name.downcase}_usdt"
    end
  end
end
