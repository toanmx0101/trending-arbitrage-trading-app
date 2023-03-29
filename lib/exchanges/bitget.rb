module Exchanges
  class Bitget < BaseExchange
    API_ENDPOINT = "https://api.bitget.com/api/spot/v1/market"
    SYMBOLS_URL = "#{API_ENDPOINT}/tickers"

    def symbols
      response = HttpAbstractor.get(SYMBOLS_URL)
      response.body["data"].select do |pair|
        pair["usdtVol"].to_f > 50000 && pair["symbol"].end_with?("USDT")
      end.map do |pair|
        pair["symbol"].gsub("USDT", "")
      end
    end

    def price(coin_name)
      response = HttpAbstractor.get(ticket_url(coin_name))
      response.body["data"]["close"].to_f
    end

    def ticket_url coin_name
      "#{API_ENDPOINT}/ticker?symbol=#{symbol(coin_name)}"
    end

    def symbol(coin_name)
      "#{coin_name}USDT_SPBL"
    end

    def symbol_prefix
      ""
    end
  end
end