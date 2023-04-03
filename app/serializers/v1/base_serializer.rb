# frozen_string_literal: true

module V1
  class BaseSerializer
    include JSONAPI::Serializer

    set_key_transform :camel_lower
  end
end
