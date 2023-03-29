class Api::ExchangesController < ::ApplicationController
    before_action :set_exchange, only: %i[ show edit update destroy ]
end