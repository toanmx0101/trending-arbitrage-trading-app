# frozen_string_literal: true

json.extract! ticker, :id, :exchanges_id, :base_currency, :quote_currency, :last_price, :bid_price, :ask_price,
              :last_24h_volume, :created_at, :updated_at
json.url ticker_url(ticker, format: :json)
