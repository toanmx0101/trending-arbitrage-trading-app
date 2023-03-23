require "./lib/exchanges/base_exchange.rb"
require "./lib/redis_marshal.rb"
require "pry"

module Exchanges
  class Mexc < BaseExchange
    API_ENDPOINT = "https://www.mexc.com"
    SPOT_TRADE_ENDPOINT = "https://www.mexc.com/exchange/"

    def price(coin_name)
      response = HttpAbstractor.get(ticket_url, { symbol: symbol(coin_name)})
      response.body["data"].first["last"].to_f
    end

    def orders(coin_name)
      response = HttpAbstractor.get(orderbook_url, { symbol: symbol(coin_name), depth: 200 })
      response.body["data"]
    end

    def bids coin_name
      orders(coin_name)["bids"].map do |b|
        {
          "symbol" => symbol(coin_name),
          "price" => b["price"].to_f,
          "size" => b["quantity"].to_f,
          "side" => "Sell",
        }
      end
    end

    def asks coin_name
      orders(coin_name)["asks"].map do |b|
        {
          "symbol" => symbol(coin_name),
          "price" => b["price"].to_f,
          "size" => b["quantity"].to_f,
          "side" => "Buy",
        }
      end
    end

    def spot_trade_url coin_name
      "#{SPOT_TRADE_ENDPOINT}#{symbol(coin_name)}"
    end

    def ignore_symbol? coin_name
      ["GMT", "GAS", "SHIBA", "HERO"].include? coin_name
    end

    def currency_info coin_name
      data = RedisMarshal.fetch("mexc_all_currencys") do
        HttpAbstractor.get(symbols_url).body["data"]
      end

      data.find {|currency| currency["currency"] == coin_name}
    end

    def support_withdraw? coin_name
      currency_info(coin_name) && currency_info(coin_name)["coins"].any? {|c| c["is_withdraw_enabled"] }
    end

    def support_deposit? coin_name
      currency_info(coin_name) && currency_info(coin_name)["coins"].any? {|c| c["is_deposit_enabled"] }
    end

    def withdraw_fee coin_name, price
      currency_info(coin_name)["coins"].select { |c| c["is_withdraw_enabled"] }
                                       .map { |c| "#{c["chain"]} #{(c["fee"] * price).round(2)}$" }
    end

    private

    def ticket_url
      "#{API_ENDPOINT}/open/api/v2/market/ticker"
    end

    def orderbook_url
      "#{API_ENDPOINT}/open/api/v2/market/depth"
    end

    def symbols_url
      "#{API_ENDPOINT}/open/api/v2/market/coin/list"
    end

    def symbol_prefix
      "_"
    end
  end
end