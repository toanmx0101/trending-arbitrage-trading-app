class AddFeesToTickerPairs < ActiveRecord::Migration[7.0]
  def change
    add_column :ticker_pairs, :withdraw_fee, :float, default: 0
    add_column :ticker_pairs, :deposit_fee, :float, default: 0
  end
end
