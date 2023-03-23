Dir["./lib/exchange/*.rb"].each {|file| require file }

class SymbolsHelper
  def self.all_symbols
    bybit_symbols = Exchange::Bybit.symbols || []
    ftx_symbols = Exchange::DeprecatedFTX.symbols rescue []
    bkex_symbols = Exchange::Bkex.symbols || []
    (bybit_symbols + ftx_symbols + bkex_symbols).uniq
  end

  def self.find_duplicate_symbols(exchanges = [], without_stable_coins: true)
    symbols = Exchange.const_get(exchanges.first).symbols rescue []

    exchanges.each do |exchange_name|
      symbols = symbols & Exchange.const_get(exchange_name).symbols
    end

    symbols -= stable_coins if without_stable_coins

    symbols
  end

  def self.stable_coins
    ["USDC", "USDT"]
  end
end
