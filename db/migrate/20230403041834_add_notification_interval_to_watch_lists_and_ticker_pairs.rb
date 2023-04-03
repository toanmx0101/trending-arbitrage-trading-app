# frozen_string_literal: true

class AddNotificationIntervalToWatchListsAndTickerPairs < ActiveRecord::Migration[7.0]
  def change
    add_column :watch_lists, :notification_interval, :string
    add_column :ticker_pairs, :notification_interval, :string
  end
end
