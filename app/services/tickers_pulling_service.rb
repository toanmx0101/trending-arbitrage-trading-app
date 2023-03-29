class TickersPullingService
  prepend SimpleCommand

  def initialize(exchange)
    @exchange = exchange
  end

  def call
    if @exchange.exchange_klass.present? && Exchanges.const_get(@exchange.exchange_klass).present?
      symbols = Exchanges.const_get(@exchange.exchange_klass).symbols
      symbols.each do |symbol|
        currency = Currency.find_or_create_by(
          symbol: symbol.upcase,
          name: symbol.upcase
        )

        next if symbol.include?("$") || symbol.include?("_")
        @exchange.tickers.find_or_create_by!(
          currency:,
          base_currency: symbol.upcase,
          quote_currency: "USDT",
        )
      end
    end
  end
end