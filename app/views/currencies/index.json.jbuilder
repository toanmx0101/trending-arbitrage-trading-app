# frozen_string_literal: true

json.array! @currencies, partial: 'currencies/currency', as: :currency
