class DashboardController < ApplicationController
  def index

  end

  def trending_cryptocurrencies
    @trending_cryptocurrencies = ["XHR", "SHIBONE", "FCC"]
  end
end