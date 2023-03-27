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
    panel "Tickers" do
      table_for currency.tickers.order(base_currency: :asc) do
        column :id
        column :exchange
        column :base_currency
        column :quote_currency
        column :last_price
        column :current_price
        column :last_24h_volume
        column :bid_price
        column :ask_price
      end
    end
  end

  searchable_select_options(
    name: :search_currency,
    scope: Currency.all,
    text_attribute: :symbol,
    display_text: ->(record) { record.symbol } )
end
