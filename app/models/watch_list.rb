class WatchList < ApplicationRecord
  belongs_to :currency
  belongs_to :user

  after_create_commit :create_scheduled_job
  after_destroy_commit :stop_scheduled_job

  def create_scheduled_job
    Sidekiq.set_schedule("TickerWatcherJob_#{schedule}_#{self.id}", { every: [schedule], class: "TickerWatcherJob", args: [self.id] })
  end

  def stop_scheduled_job
    Sidekiq.remove_schedule("TickerWatcherJob_#{schedule}_#{self.id}")
  end
end
