# frozen_string_literal: true

module Exchanges
  class Lbank < BaseExchange
    API_ENDPOINT = 'https://api.lbkex.com/v2'
    SYMBOLS_URL = "#{API_ENDPOINT}/currencyPairs.do".freeze
    TICKER_URL = "#{API_ENDPOINT}/ticker.do".freeze

    def price(coin_name)
      response = HttpAbstractor.get(TICKER_URL, { symbol: symbol(coin_name) })
      response.body['data'].first['ticker']['latest'].to_f
    end

    def symbols
      response = HttpAbstractor.get(SYMBOLS_URL)
      response.body['data'].map(&:upcase).select do |pair|
        pair.include?('_USDT') && !pair.end_with?('3S_USDT') && !pair.end_with?('5S_USDT') && !pair.end_with?('3L_USDT') && !pair.end_with?('5L_USDT')
      end.map do |pair|
        pair.gsub('_USDT', '')
      end
    end

    def symbol(coin_name)
      "#{coin_name.downcase}_USDT".downcase
    end
  end
end
