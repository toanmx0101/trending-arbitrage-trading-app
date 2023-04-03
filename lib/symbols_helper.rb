# frozen_string_literal: true

Dir['./lib/exchange/*.rb'].each { |file| require file }

class SymbolsHelper
  def self.all_symbols
    bybit_symbols = Exchange::Bybit.symbols || []
    ftx_symbols = begin
      Exchange::Ftx.symbols
    rescue StandardError
      []
    end
    bkex_symbols = Exchange::Bkex.symbols || []
    (bybit_symbols + ftx_symbols + bkex_symbols).uniq
  end

  def self.find_duplicate_symbols(exchanges = [], without_stable_coins: true)
    symbols = begin
      Exchange.const_get(exchanges.first).symbols
    rescue StandardError
      []
    end

    exchanges.each do |exchange_name|
      symbols &= Exchange.const_get(exchange_name).symbols
    end

    symbols -= stable_coins if without_stable_coins

    symbols
  end

  def self.stable_coins
    %w[USDC USDT]
  end
end
