# frozen_string_literal: true

module Api
  module V1
    class CurrenciesController < BaseController
      def index
        @all_currencies = Currency.all

        render_collection pagy(@all_currencies), serializer: ::V1::CurrencySerializer
      end

      def show; end
    end
  end
end
