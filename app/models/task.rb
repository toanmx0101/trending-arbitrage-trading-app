# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  searchkick callbacks: :async, index_name: "task_#{Rails.env}", word_start: %i[title description]

  def search_data
    {
      id:,
      title:,
      description:,
      is_completed:,
      deadline:,
      created_at:,
      user_id:
    }
  end

  def is_overdue?
    incomplete? && Time.now > deadline
  end

  def incomplete?
    !is_completed?
  end
end
