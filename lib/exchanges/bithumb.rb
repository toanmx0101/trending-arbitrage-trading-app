module Exchanges
  class Bithumb < BaseExchange
    API_ENDPOINT = "https://api.bithumb.com"
    SYMBOLS_URL = "#{API_ENDPOINT}/spot/currencies"
    TICKET_URL = "#{API_ENDPOINT}/public/ticker"
  end
end