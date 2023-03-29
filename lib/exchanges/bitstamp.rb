module Exchanges
  class Bitstamp < BaseExchange
    API_ENDPOINT = "https://www.bitstamp.net/api/v2"
    SYMBOLS_URL = "#{API_ENDPOINT}/ticker/"
    TICKET_URL = "#{API_ENDPOINT}/ticker/"

    def symbols
      response = HttpAbstractor.get(SYMBOLS_URL)
      response.body.select do |pair|
        pair["pair"].end_with?("/USDT")
      end.map do |pair|
        pair["pair"].gsub("/USDT", "")
      end
    end

    def price(coin_name)
      response = HttpAbstractor.get(ticket_url(coin_name))
      response.body["last"].to_f
    end

    def ticket_url(coin_name)
      "#{TICKET_URL}#{symbol(coin_name)}"
    end

    def symbol(coin_name)
      "#{coin_name}USDT".downcase
    end
  end
end