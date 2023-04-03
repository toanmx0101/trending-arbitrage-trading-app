# frozen_string_literal: true

class DashboardController < ApplicationController
  def index; end

  def trending_cryptocurrencies
    @trending_cryptocurrencies = %w[XHR SHIBONE FCC]
  end
end
