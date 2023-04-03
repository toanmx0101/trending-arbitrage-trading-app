# frozen_string_literal: true

module Api
  class TickersController < ::ApplicationController
    before_action :set_ticker, only: %i[show edit update destroy]

    def index; end
  end
end
