# frozen_string_literal: true

json.array! @tickers, partial: 'tickers/ticker', as: :ticker
