# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      include ActionController::HttpAuthentication::Token::ControllerMethods
      include Paginable
      include Pagy::Backend

      before_action :authenticate_request!

      rescue_from(
        StandardError,
      ) do |error|
        handle_error(error.try(:status) || 400, [error.message])
      end

      protected def handle_error(status, error_messages = [])
        render json: { data: nil, errors: error_messages }, status:
      end

      private def current_user
        @current_user
      end

      private def authenticate_request!
        authenticate_or_request_with_http_token do |token, options|
          user = User.find_by(token: token)

          if user
            @current_user = user
          else
            render json: { error: 'Invalid token' }, status: :unauthorized
          end
        end
      end
    end
  end
end
