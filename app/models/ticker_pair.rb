# frozen_string_literal: true

class TickerPair < ApplicationRecord
  include AASM

  acts_as_paranoid

  belongs_to :currency
  belongs_to :first_ticker, class_name: 'Ticker', foreign_key: 'first_ticker_id'
  belongs_to :second_ticker, class_name: 'Ticker', foreign_key: 'second_ticker_id'
  belongs_to :user

  after_destroy_commit :stop_scheduled_job

  enum :status, %i[stop running canceled]

  aasm column: :status, whiny_transitions: false, enum: true do
    state :stop, initial: true
    state :running, :canceled

    event :start do
      transitions from: [:stop], to: :running, after: :create_scheduled_job
    end

    event :stop do
      transitions from: [:running], to: :stop, after: :stop_scheduled_job
    end

    event :canceled do
      transitions from: [:running], to: :canceled, after: :stop_scheduled_job
    end
  end

  def create_scheduled_job
    Sidekiq.set_schedule("TickerPairWatcherJob_#{scheduler}_#{id}",
                         { every: [scheduler], class: 'TickerPairWatcherJob', args: [id] })
  end

  def stop_scheduled_job
    Sidekiq.remove_schedule("TickerPairWatcherJob_#{scheduler}_#{id}")
  end
end
