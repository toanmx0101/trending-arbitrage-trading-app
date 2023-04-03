# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Configure parameters to be filtered from the log file. Use this to limit dissemination of
# sensitive information. See the ActiveSupport::ParameterFilter documentation for supported
# notations and behaviors.
Rails.application.config.filter_parameters += %i[
  passw secret token _key crypt salt certificate otp ssn
]

module FilterSpec
  FILTERED = "[FILTERED]".freeze
  FILTERED_MAX_LENGTH = 70

  def filter_sensitive(value)
    case value
    when Array, Hash then value.filtered
    when String then value.truncate(FILTERED_MAX_LENGTH)
    when ActiveRecord::Base then value.try(:to_global_id).try(:to_s) || value.to_s
    else value
    end
  rescue StandardError => e
    value
  end
end

class Hash
  include FilterSpec

  def filtered
    hash = transform_values { |value| filter_sensitive(value) }
    filterer.filter hash
  rescue StandardError => e
    self
  end

  private def filterer
    @filterer ||= ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
  end
end

class Array
  include FilterSpec

  def filtered
    map { |item| filter_sensitive(item) }
  end
end
