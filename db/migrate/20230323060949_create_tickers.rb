class CreateTickers < ActiveRecord::Migration[7.0]
  def change
    create_table :tickers do |t|
      t.belongs_to :exchange, null: false, foreign_key: true
      t.string :base_currency
      t.string :quote_currency
      t.float :last_price
      t.float :bid_price
      t.float :ask_price
      t.float :last_24h_volume

      t.timestamps
    end
  end
end
