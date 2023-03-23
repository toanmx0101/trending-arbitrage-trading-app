module Exchanges
    class Bitso < BaseExchange
      API_ENDPOINT = "https://bitso.com/api/v3"
      SYMBOLS_URL = "#{API_ENDPOINT}/available_books/"
      TICKET_URL = "#{API_ENDPOINT}/ticker/"

      def symbols
        response = HttpAbstractor.get(SYMBOLS_URL)
        response.body["payload"].select do |pair|
            pair["book"].end_with?("_usdt")
        end.map { |s| s["book"] }
      end

      def price(coin_name)
      end
    end
  end