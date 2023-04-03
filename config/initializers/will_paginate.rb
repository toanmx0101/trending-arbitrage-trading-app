# frozen_string_literal: true

if defined?(WillPaginate)
  ActiveSupport.on_load :active_record do
    module WillPaginate
      module ActiveRecord
        module RelationMethods
          def per(value = nil) = per_page(value)
          def total_count = count
        end
      end

      module CollectionMethods
        alias num_pages total_pages
      end
    end
  end
end
