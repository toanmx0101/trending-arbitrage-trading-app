class AddSpreadThresholdAlertToTickerPairs < ActiveRecord::Migration[7.0]
  def change
    add_column :ticker_pairs, :spread_threshold_alert, :float, default: 0
  end
end
