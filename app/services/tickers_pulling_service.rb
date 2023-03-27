class TickersPullingService
  prepend SimpleCommand

  def initialize(exchange)
    @exchange = exchange
  end

  def call
    if @exchange.exchange_klass.present? && Exchanges.const_get(@exchange.exchange_klass).present?
      symbols = Exchanges.const_get(@exchange.exchange_klass).symbols
      symbols.each do |symbol|
        next if symbol.include?("$") || symbol.include?("_")
        @exchange.tickers.find_or_create_by!(
          base_currency: symbol.upcase,
          quote_currency: "USDT",
        )

        if Currency.find_by(symbol:).nil?
          Currency.create(
            symbol: symbol,
            name: symbol
          )
        end
      end
    end
  end
end