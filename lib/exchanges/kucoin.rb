require "./lib/exchanges/base_exchange.rb"

module Exchanges
  class Kucoin < BaseExchange
    API_ENDPOINT = "https://api.kucoin.com"

    def price coin_name
      response = HttpAbstractor.get(ticket_url(coin_name), { symbol: "#{symbol(coin_name)}"})
      response.body["data"]["price"].to_f
    end

    def orders coin_name
      response = HttpAbstractor.get(orderbook_url(coin_name))
      response.body
    end

    def bids coin_name
      orders(coin_name)["bids"].map do |b|
        {
          "symbol" => symbol(coin_name),
          "price" => b[0].to_f,
          "size" => b[1].to_f,
          "side" => "Sell",
        }
      end
    end

    def asks(coin_name)
      orders(coin_name)["asks"].map do |b|
        {
          "symbol" => symbol(coin_name),
          "price" => b[0].to_f,
          "size" => b[1].to_f,
          "side" => "Buy",
        }
      end
    end

    def ignore_symbol? coin_name
      ["DMG", "BRG"].include? coin_name
    end

    def symbols
      response = HttpAbstractor.get(symbols_url)
      data = response.body["data"].select { |symbol| symbol["quoteCurrency"] == default_currency }
      data = data.map { |symbol| symbol["name"].gsub("#{symbol_prefix}#{default_currency}", "") }
      data.reject { |symbol| symbol.index("3L") || symbol.index("3S") || symbol.index("5L") || symbol.index("5S") }
    end

    private

    def symbol_prefix
      "-"
    end

    def ticket_url coin_name
      "#{API_ENDPOINT}/api/v1/market/orderbook/level1"
    end

    def orderbook_url coin_name
      "#{API_ENDPOINT}/api/v1/market/orderbook/level2_200?symbol=#{symbol(coin_name)}"
    end

    def symbols_url
      "#{API_ENDPOINT}/api/v1/symbols"
    end
  end
end