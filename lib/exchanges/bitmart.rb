# frozen_string_literal: true

module Exchanges
  class Bitmart < BaseExchange
    API_ENDPOINT = 'https://api.bithumb.com'
    SYMBOLS_URL = 'https://api-cloud.bitmart.com/spot/v2/ticker'
    TICKET_URL = 'https://api-cloud.bitmart.com/spot/v1/ticker'
    SPOT_TRADE_ENDPOINT = 'https://www.bitmart.com/trade/en-US?symbol='

    def symbols
      response = HttpAbstractor.get(SYMBOLS_URL)
      response.body['data']['tickers']
              .select { |pair| pair['symbol'].end_with?('_USDT') && pair['quote_volume_24h'].to_f > 20_000 }
              .map { |pair| pair['symbol'].gsub('_USDT', '') }
    end

    def price(coin_name)
      response = HttpAbstractor.get(ticket_url(coin_name))
      response.body['data']['tickers'].first['last_price'].to_f
    end

    def ticket_url(coin_name)
      "#{TICKET_URL}?symbol=#{symbol(coin_name)}"
    end

    def symbol_prefix
      '_'
    end

    def spot_trade_url(coin_name)
      "#{SPOT_TRADE_ENDPOINT}#{coin_name}_USDT"
    end
  end
end
