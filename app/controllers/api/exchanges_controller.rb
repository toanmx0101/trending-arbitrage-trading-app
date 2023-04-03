# frozen_string_literal: true

module Api
  class ExchangesController < ::ApplicationController
    before_action :set_exchange, only: %i[show edit update destroy]
  end
end
