# frozen_string_literal: true

module RansackSearchable
  extend ActiveSupport::Concern

  included do
    def self.search_by_attribute(attribute_names, value, with_id: false)
      attribute_names = [attribute_names] if attribute_names.is_a?(String)
      str_attribute_name = attribute_names.select { |attr| column_names.include?(attr) }.join(' || ')

      return [] unless str_attribute_name.present?

      q = value.to_s.downcase.tr(' ', '')
      qs = ["LOWER(#{str_attribute_name}) like :q"]
      qs << 'cast(id as text) like :q' if with_id
      where(qs.join(' OR '), q: "%#{q}%")
    end
  end
end
