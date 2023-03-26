class AddInfoToTickerPairs < ActiveRecord::Migration[7.0]
  def change
    add_column :ticker_pairs, :scheduled_sidekiq_job_id, :string
    add_column :ticker_pairs, :status, :integer, default: 0
    add_column :ticker_pairs, :spread, :float
    add_column :ticker_pairs, :deleted_at, :datetime, index: true
  end
end
