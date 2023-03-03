# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from(
    StandardError,
  ) do |error|
    redirect_to "/404.html"
  end
end
