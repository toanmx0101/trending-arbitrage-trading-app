module Paginable
  extend ActiveSupport::Concern

  def paginate(collection, pagination_params)
    JSOM::Pagination::Paginator.new.call(collection, params: pagination_params, base_url: request.url)
  end

  def render_collection(paginated, serializer: nil, additional_options: {})
    pagy, records = paginated

    options = {
      meta: {
        count: pagy.count,
        page: pagy.page,
      },
      **additional_options,
    }

    paginated_result =
      if serializer
        serializer.new(records, options)
      else
        records
      end

    if serializer
      render json: paginated_result
    else
      render json: {
        data: paginated_result,
        **options,
      }
    end
  end
end
