# frozen_string_literal: true

json.array! @watch_lists, partial: 'watch_lists/watch_list', as: :watch_list
