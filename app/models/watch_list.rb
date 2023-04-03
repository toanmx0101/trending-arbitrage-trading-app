# frozen_string_literal: true

class WatchList < ApplicationRecord
  belongs_to :currency
  belongs_to :user

  after_create_commit :create_scheduled_job
  after_destroy_commit :stop_scheduled_job

  def create_scheduled_job
    Sidekiq.set_schedule("TickerWatcherJob_#{schedule}_#{id}",
                         { every: [schedule], class: 'TickerWatcherJob', args: [id] })
  end

  def stop_scheduled_job
    Sidekiq.remove_schedule("TickerWatcherJob_#{schedule}_#{id}")
  end
end
