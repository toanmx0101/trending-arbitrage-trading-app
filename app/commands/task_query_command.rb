# frozen_string_literal: true

class TaskQueryCommand
  prepend SimpleCommand

  def initialize(args = {})
    @args = args
  end

  def call
    Task.search(keyword_search, **options, page:, per_page: limit)
  end

  private

  def keyword_search
    @args[:keyword_search].presence || '*'
  end

  def page
    @args[:page].presence || 0
  end

  def limit
    @args[:limit].presence || 5
  end

  def deadline
    if @args[:due_today] == '1'
      Time.now.end_of_day
    else
      999.years.from_now
    end
  end

  def query
    {
      user_id: @args[:current_user].id,
      deadline: {
        lt: deadline
      }
    }
  end

  def order
    sort_by = @args[:sort_by].presence || 'deadline'
    sort_order = @args[:sort_order].presence || 'asc'

    {
      sort_by => sort_order,
    }
  end

  def options
    {
      where: query,
      fields: %i[title description],
      match: :word_start,
      order:,
    }
  end
end
