class Exchange < ApplicationRecord
  paginates_per 50
  has_many :tickers

  def api_endpoint
    if exchange_klass && Exchanges.const_get(exchange_klass).present?
      Exchanges.const_get(exchange_klass)::API_ENDPOINT
    end
  end
end
