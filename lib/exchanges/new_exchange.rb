# frozen_string_literal: true

module Exchanges
  class NewExchange < BaseExchange
    API_ENDPOINT = 'https://api.bithumb.com'
    SYMBOLS_URL = "#{API_ENDPOINT}/spot/currencies".freeze
    TICKET_URL = "#{API_ENDPOINT}/public/ticker".freeze

    def symbols
      response = HttpAbstractor.get(SYMBOLS_URL)
      response.body['payload'].select do |pair|
        pair['book'].end_with?('_usdt')
      end.map { |s| s['book'] }
    end

    def price; end
  end
end
