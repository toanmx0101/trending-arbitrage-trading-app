# frozen_string_literal: true

class AddIsCompletedToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :is_completed, :boolean, default: false
  end
end
