ActiveAdmin.register Currency do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :symbol, :website, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :symbol, :website, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  show do
    attributes_table(*default_attribute_table_rows)

    panel "Watch lists" do
      table_for currency.watch_lists do
        column :id
        column :schedule
        column :spread_threshold_alert
        column :spread
        column :created_at
        column :updated_at
      end
    end

    panel "Tickers" do
      table_for currency.tickers.order(base_currency: :asc) do
        column :id
        column :exchange
        column :last_price
        column :ticker do |resource|
          link_to "#{resource.base_currency}/#{resource.quote_currency}", resource.spot_trade_url
        end
        column :last_24h_volume
        column :bid_price
        column :ask_price
        column :updated_at
      end
    end
  end

  action_item :add_to_watch_list, only: :show, index: 0 do
    link_to "Add to watch list", add_to_watch_list_admin_currency_path(resource)
  end

  member_action :add_to_watch_list do
    WatchList.create!(
      user: current_user,
      currency: resource,
      schedule: "1m"
    )
    redirect_to admin_currency_path(resource)
  end

  searchable_select_options(
    name: :search_currency,
    scope: Currency.all,
    text_attribute: :symbol,
    collection: -> {
      Currency.all.map { |record| [record.symbol, record.symbol] }
    },
    display_text: ->(record) { record.symbol } )
end
