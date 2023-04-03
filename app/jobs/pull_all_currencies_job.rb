# frozen_string_literal: true

require 'sidekiq-scheduler'

class PullAllCurrenciesJob
  include Sidekiq::Worker

  def perform
    Exchange.all.each do |exchange|
      TickersPullingService.call(exchange)
    end
  end
end
