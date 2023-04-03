# frozen_string_literal: true

json.extract! exchange, :id, :name, :description, :created_at, :updated_at
json.url exchange_url(exchange, format: :json)
