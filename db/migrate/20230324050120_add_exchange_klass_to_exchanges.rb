# frozen_string_literal: true

class AddExchangeKlassToExchanges < ActiveRecord::Migration[7.0]
  def change
    add_column :exchanges, :exchange_klass, :string
  end
end
