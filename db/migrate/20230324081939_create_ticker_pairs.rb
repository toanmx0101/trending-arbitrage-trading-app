class CreateTickerPairs < ActiveRecord::Migration[7.0]
  def change
    create_table :ticker_pairs do |t|
      t.belongs_to :currency, null: false, foreign_key: true
      t.references :first_ticker, index: true, foreign_key: { to_table: :tickers }
      t.references :second_ticker, index: true, foreign_key: { to_table: :tickers }

      t.string :scheduler
      t.string :tele_channel_id
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
