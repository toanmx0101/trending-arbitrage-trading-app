# frozen_string_literal: true

require './lib/http_abstractor'
require 'json'

module Exchanges
  class BaseExchange
    API_ENDPOINT = ''

    def initialize; end

    def all_tickers(_base_currency)
      []
    end

    def ticket_url(_coin_name)
      ''
    end

    def orderbook_url(_coin_name)
      ''
    end

    def price(_coin_name)
      0
    end

    def orders(coin_name)
      response = HttpAbstractor.get(orderbook_url(coin_name))

      response.body
    end

    def bids(_coin_name)
      []
    end

    def asks(_coin_name)
      []
    end

    def ignore_symbol?(_coin_name)
      false
    end

    def symbols
      []
    end

    def buyable_orders(coin_name, price_ceiling)
      bids(coin_name).select do |bid|
        bid['price'].to_f <= price_ceiling
      end
    end

    def sellable_orders(coin_name, price_floor)
      ask(coin_name).select do |ask|
        ask['price'] >= price_floor
      end
    end

    def support_deposit?(_coin_name)
      true
    end

    def support_withdraw?(_coin_name)
      true
    end

    def support_trade?(_coin_name)
      true
    end

    def withdraw_fee(_coin_name, _price)
      0
    end

    def last_ask_price(_coin_name)
      0
    end

    def last_bid_price(_coin_name)
      0
    end

    def spot_trade_url(_coin_name)
      ''
    end

    def symbols
      []
    end

    #######################
    #### CLASS METHODS ####
    #######################

    def self.price(coin_name)
      exchange = new
      exchange.price(coin_name)
    end

    def self.symbols
      exchange = new
      exchange.symbols
    end

    def self.spot_trade_url(coin_name)
      exchange = new
      exchange.spot_trade_url(coin_name)
    end

    def self.symbol(coin_name)
      exchange = new
      exchange.symbol(coin_name)
    end

    def symbol(name)
      "#{name}#{symbol_prefix}#{default_currency}"
    end

    def symbol_prefix
      ''
    end

    def default_currency
      'USDT'
    end
  end
end
