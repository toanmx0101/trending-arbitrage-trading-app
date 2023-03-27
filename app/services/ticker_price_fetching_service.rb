class TickerPriceFetchingService
  prepend SimpleCommand

  def initialize(ticker)
    @ticker = ticker
  end

  def call
    return if @ticker.exch.nil?

    update_ticker_last_price
  end

  private

  def update_ticker_last_price
    @ticker.update(
      last_price: @ticker.current_price
    )
  end
end