require "./lib/exchanges/base_exchange.rb"

module Exchanges
  class Gateio < BaseExchange
    API_ENDPOINT = "https://api.gateio.ws/api/v4"
    SYMBOLS_URL = "#{API_ENDPOINT}/spot/currencies"
    TICKET_URL = "#{API_ENDPOINT}/spot/tickers"
    SPOT_TRADE_ENDPOINT = "https://www.gate.io/trade/"

    def symbols
      response = HttpAbstractor.get(SYMBOLS_URL)
      response.body.select do |pair|
        !pair["delisted"] &&
        !pair["trade_disabled"] &&
        !pair["withdraw_disabled"] &&
        !pair["withdraw_delayed"] &&
        !pair["deposit_disabled"] &&
        !pair["currency"].include?("_") &&
        !pair["currency"].include?("$")
      end.map { |s| s["currency"] }
    end

    def price(coin_name)
      response = HttpAbstractor.get(ticket_url(coin_name))
      response.body.first["last"].to_f
    end

    def spot_trade_url(coin_name)
      "#{SPOT_TRADE_ENDPOINT}#{symbol(coin_name)}"
    end

    private

    def ticket_url coin_name
      "#{TICKET_URL}?currency_pair=#{symbol(coin_name)}"
    end

    def symbol_prefix
      "_"
    end
  end
end