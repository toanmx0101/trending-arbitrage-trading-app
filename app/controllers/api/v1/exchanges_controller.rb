# frozen_string_literal: true

module Api
  module V1
    class ExchangesController < BaseController
      def index
        @all_exchanges = Exchange.all

        render_collection pagy(@all_exchanges), serializer: ::V1::ExchangeSerializer
      end

      def show; end
    end
  end
end
