module Exchanges
  class Poloniex < BaseExchange
    API_ENDPOINT = "https://api.poloniex.com"
    SYMBOLS_URL = "#{API_ENDPOINT}/markets"
    TICKET_URL = "#{API_ENDPOINT}/"
    SPOT_TRADE_ENDPOINT = "https://poloniex.com/trade/"

    def symbols
      response = HttpAbstractor.get(SYMBOLS_URL)
      response.body.select do |pair|
          pair["quoteCurrencyName"] == "USDT"
      end.map { |s| s["baseCurrencyName"] }
    end

    def price(coin_name)
      response = HttpAbstractor.get(ticket_url(coin_name.upcase))
      response.body["price"].to_f
    end

    def spot_trade_url coin_name
      "#{SPOT_TRADE_ENDPOINT}#{coin_name}_USDT"
    end

    private

    def ticket_url(coin_name)
      "#{API_ENDPOINT}/markets/#{symbol(coin_name)}/price"
    end

    def symbol_prefix
      "_"
    end
  end
end