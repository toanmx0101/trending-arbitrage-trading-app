# frozen_string_literal: true

class AddLastRunAtToTickerPairs < ActiveRecord::Migration[7.0]
  def change
    add_column :ticker_pairs, :last_run_at, :datetime
  end
end
