class Ticker < ApplicationRecord
  include ::RansackSearchable

  belongs_to :exchange
  belongs_to :currency

  def spot_trade_url
    exch.spot_trade_url(base_currency)
  end

  def symbol
    exch.symbol(base_currency)
  end

  def exch
    @exch ||= Exchanges.const_get(exchange.exchange_klass)
  end

  def self.search_by_name(name, with_id: false)
    q = name.to_s.downcase.tr(' ', '')
    qs = ['LOWER(base_currency) like :q']
    qs << 'cast(id as text) like :q' if with_id
    where(qs.join(' OR '), q: "%#{q}%")
  end
end
