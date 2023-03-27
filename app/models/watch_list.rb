class WatchList < ApplicationRecord
  belongs_to :currency
  belongs_to :user

  after_create

  def create_scheduled_job
    Sidekiq.set_schedule("TickerWatcherJob_#{scheduler}_#{self.id}", { every: [scheduler], class: "TickerWatcherJob", args: [self.id] })
  end
end
