ActiveAdmin.register Ticker do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :exchanges_id, :base_currency, :quote_currency, :last_price, :bid_price, :ask_price, :last_24h_volume, :currency
  #
  # or
  #
  # permit_params do
  #   permitted = [:exchanges_id, :base_currency, :quote_currency, :last_price, :bid_price, :ask_price, :last_24h_volume]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :id, sortable: true
    column :exchange
    column(:base_currency) { |item| link_to item.symbol, item.spot_trade_url, target: "_blank"}
    column :last_price
    column :bid_price
    column :ask_price
    column :last_24h_volume

    actions
  end

  searchable_select_options(
    name: :search_by_currency,
    scope: -> {
      if params[:currency_id].present?
        currency = Currency.find(params[:currency_id])
        Ticker.includes(:exchange)
              .order(:base_currency)
              .where(base_currency: currency.symbol)
              .search_by_name(params[:term])
      else
        Ticker.includes(:exchange)
              .order(:base_currency)
              .search_by_name(params[:term])
      end
    },
    text_attribute: :base_currency,
    display_text: -> (record) { "#{record.exchange.name} - #{record.base_currency}/#{record.quote_currency}" }
  )
end
