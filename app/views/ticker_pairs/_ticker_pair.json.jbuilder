# frozen_string_literal: true

json.extract! ticker_pair, :id, :currency_id, :first_ticker_id, :second_ticker_id, :scheduler, :tele_channel_id,
              :user_id, :created_at, :updated_at
json.url ticker_pair_url(ticker_pair, format: :json)
