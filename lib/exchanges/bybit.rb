# frozen_string_literal: true

require './lib/exchanges/base_exchange'

module Exchanges
  class Bybit < BaseExchange
    SPOT_TRADE_ENDPOINT = 'https://www.bybit.com/en-US/trade/spot/'
    API_ENDPOINT = 'https://api.bybit.com/'

    def price(coin_name)
      response = HttpAbstractor.get(ticket_url(coin_name.upcase))
      response.body['result'].first['last_price'].to_f
    end

    # List long order
    def bids(coin_name)
      orders(coin_name)['result'].select { |i| i['side'] == 'Sell' }
    end

    def asks(coin_name)
      orders(coin_name)['result'].select { |i| i['side'] == 'Buy' }
    end

    def orders(coin_name)
      response = HttpAbstractor.get(orderbook_url(coin_name))
      response.body
    end

    def symbols
      response = HttpAbstractor.get(symbols_url)
      begin
        response.body['result']
      rescue StandardError
        []
      end.select { |symbol| symbol['quote_currency'] == default_currency }
        .map do |symbol|
        symbol['name'].gsub("#{symbol_prefix}#{default_currency}",
                            '')
      end
    end

    def spot_trade_url(coin_name)
      "#{SPOT_TRADE_ENDPOINT}#{coin_name}/USDT"
    end

    private

    def ticket_url(coin_name)
      "#{API_ENDPOINT}/v2/public/tickers?symbol=#{symbol(coin_name)}"
    end

    def orderbook_url(coin_name)
      "#{API_ENDPOINT}/v2/public/orderBook/L2?symbol=#{symbol(coin_name)}"
    end

    def symbols_url
      "#{API_ENDPOINT}/v2/public/symbols"
    end
  end
end
