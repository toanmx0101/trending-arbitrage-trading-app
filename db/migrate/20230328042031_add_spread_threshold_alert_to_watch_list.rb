class AddSpreadThresholdAlertToWatchList < ActiveRecord::Migration[7.0]
  def change
    add_column :watch_lists, :spread_threshold_alert, :float, default: 1.5
  end
end
