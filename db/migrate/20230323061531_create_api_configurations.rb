# frozen_string_literal: true

class CreateApiConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :api_configurations do |t|
      t.belongs_to :exchange, null: false, foreign_key: true
      t.string :version
      t.string :base_endpoint
      t.integer :rate
      t.string :official_link

      t.timestamps
    end
  end
end
