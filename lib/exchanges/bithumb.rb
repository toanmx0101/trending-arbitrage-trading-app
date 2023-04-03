# frozen_string_literal: true

module Exchanges
  class Bithumb < BaseExchange
    API_ENDPOINT = 'https://api.bithumb.com'
    SYMBOLS_URL = "#{API_ENDPOINT}/spot/currencies".freeze
    TICKET_URL = "#{API_ENDPOINT}/public/ticker".freeze
  end
end
