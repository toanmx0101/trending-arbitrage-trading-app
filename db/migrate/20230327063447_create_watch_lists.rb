# frozen_string_literal: true

class CreateWatchLists < ActiveRecord::Migration[7.0]
  def change
    create_table :watch_lists do |t|
      t.belongs_to :currency, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :schedule

      t.timestamps
    end
  end
end
