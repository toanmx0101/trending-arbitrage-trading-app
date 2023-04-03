# frozen_string_literal: true

json.array! @exchanges, partial: 'exchanges/exchange', as: :exchange
