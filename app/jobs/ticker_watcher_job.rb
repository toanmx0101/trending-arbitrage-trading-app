
require 'sidekiq-scheduler'

class TickerWatcherJob
  include Sidekiq::Worker

  def perform(watch_list_id)
    @watch_list = WatchList.find watch_list_id
    @currency = @watch_list.currency
    @tickers = @currency.tickers

    fetch_tickers_price!
    notify_if_reach_spread_alert
  end

  private

  def fetch_tickers_price!
    @tickers.each do |ticker|
      TickerPriceFetchingService.call(ticker)
    end
  end

  def notify_if_reach_spread_alert
    max_price_ticker = @tickers.max_by(&:last_price)
    min_price_ticker = @tickers.min_by(&:last_price)

    spread = (max_price_ticker.last_price - min_price_ticker.last_price) * 100 / min_price_ticker.last_price
    @watch_list.update!(spread: spread)

    if spread >= @watch_list.spread_threshold_alert
      Notification.new.send_message("\[WL\] #{@currency.name} #{spread.round(2)}% #{max_price_ticker.exchange.name}  #{max_price_ticker.last_price}  #{min_price_ticker.exchange.name} #{min_price_ticker.last_price}")
    end
  end
end