# frozen_string_literal: true

module Api
  module V1
    class BaseController < ::ActionController::API
      before_action :authenticate_request
    end
  end
end
