require "./lib/exchanges/base_exchange.rb"

module Exchanges
  class DeprecatedFTX < BaseExchange
    API_ENDPOINT = "https://ftx.com/api"
    SPOT_TRADE_ENDPOINT = "https://ftx.com/trade/"

    def symbols
      response = HttpAbstractor.get(symbols_url)
      response.body["result"].select do |pair|
        pair["quoteCurrency"] == "USDT"
      end
    end

    def price(coin_name)
      response = HttpAbstractor.get(ticket_url(coin_name))
      response.body["result"]["last"].to_f
    end

    def bids(coin_name) # List long order
      orders(coin_name)["result"]["bids"].map do |b|
        {
          "symbol" => symbol(coin_name),
          "price" => b[0].to_f,
          "size" => b[1].to_f,
          "side" => "Sell",
        }
      end
    end

    def asks(coin_name)
      orders(coin_name)["result"]["asks"].map do |b|
        {
          "symbol" => symbol(coin_name),
          "price" => b[0].to_f,
          "size" => b[1].to_f,
          "side" => "Buy",
        }
      end
    end

    def spot_trade_url coin_name
      "#{SPOT_TRADE_ENDPOINT}#{symbol(coin_name)}"
    end

    def symbols
      response = HttpAbstractor.get(symbols_url)
      data = response.body["result"].select { |symbol| symbol["quoteCurrency"] == default_currency }
      data.map { |symbol| symbol["name"].gsub("#{symbol_prefix}#{default_currency}", "") }.reject { |symbol| symbol.index("BULL") || symbol.index("BEAR") }
    end

    private

    def ticket_url(coin_name)
      "#{API_ENDPOINT}/markets/#{symbol(coin_name)}"
    end

    def orderbook_url(coin_name)
      "#{API_ENDPOINT}/markets/#{symbol(coin_name)}/orderbook?depth=100"
    end

    def symbols_url
      "#{API_ENDPOINT}/markets"
    end

    def symbol_prefix
      "/"
    end
  end
end