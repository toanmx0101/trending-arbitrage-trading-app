class Currency < ApplicationRecord
  has_many :tickers, class_name: 'Ticker', primary_key: "symbol", foreign_key: 'base_currency'
  has_many :watch_lists
end
