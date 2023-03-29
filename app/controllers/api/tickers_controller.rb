class Api::TickersController < ::ApplicationController
  before_action :set_ticker, only: %i[ show edit update destroy ]

  def index
  end
end