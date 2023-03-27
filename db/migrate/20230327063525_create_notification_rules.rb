class CreateNotificationRules < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_rules do |t|
      t.integer :rule
      t.string :description
      t.string :name

      t.timestamps
    end
  end
end
