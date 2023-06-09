# frozen_string_literal: true

class Exchange < ApplicationRecord
  paginates_per 50
  has_many :tickers, dependent: :destroy

  def api_endpoint
    return unless exchange_klass && Exchanges.const_get(exchange_klass).present?

    Exchanges.const_get(exchange_klass)::API_ENDPOINT
  end
end
