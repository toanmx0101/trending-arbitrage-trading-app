# frozen_string_literal: true

json.array! @ticker_pairs, partial: 'ticker_pairs/ticker_pair', as: :ticker_pair
