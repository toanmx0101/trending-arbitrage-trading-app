
require 'sidekiq-scheduler'

class TickerPairWatcherJob
  include Sidekiq::Worker

  def perform(ticker_pair_id)
    @ticker_pair = TickerPair.find ticker_pair_id

    fetch_tickers_price!
    update_ticker_pair_info
  end

  private

  def fetch_tickers_price!
    TickerPriceFetchingService.call(@ticker_pair.first_ticker)
    TickerPriceFetchingService.call(@ticker_pair.second_ticker)
  end

  def update_ticker_pair_info
    first_ticker = @ticker_pair.reload.first_ticker
    second_ticker = @ticker_pair.reload.second_ticker

    lower_price = first_ticker.last_price > second_ticker.last_price ? second_ticker.last_price : first_ticker.last_price
    spread = (first_ticker.last_price - second_ticker.last_price).abs / lower_price

    @ticker_pair.update(
      last_run_at: Time.now,
      spread: (spread * 100).round(4)
    )

    if @ticker_pair.reload.spread_threshold_alert <= (spread * 100).round(4)
      Notification.new.send_message("#{@ticker_pair.currency.name} #{@ticker_pair.spread.round(1)}% #{first_ticker.exchange.name}  #{first_ticker.last_price}  #{second_ticker.exchange.name} #{second_ticker.last_price}")
    end
  end
end