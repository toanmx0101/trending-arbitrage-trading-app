
require 'sidekiq-scheduler'

class TickerPairWatcherJob
  include Sidekiq::Worker

  def perform(watch_list_id)
    @watch_list = WatchList.find watch_list_id
    @currency = @watch_list.currency
    @tickers = @currency.tickers

    fetch_tickers_price!
  end

  private

  def fetch_tickers_price!
    @tickers.each do |ticker|
      TickerPriceFetchingService.call(ticker)
    end
  end
end