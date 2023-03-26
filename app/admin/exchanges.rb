ActiveAdmin.register Exchange do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :exchange_klass
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :name
    column :exchange_klass
    column :api_endpoint

    actions
  end

  actions :all, except: [:destroy]

  action_item :pull_tickers, only: :show do
    link_to "Pull tickers", pull_tickers_admin_exchange_path(resource)
  end

  member_action :pull_tickers do
    TickersPullingService.call(resource)

    redirect_to admin_exchange_path(resource)
  end

  show do
    attributes_table(*default_attribute_table_rows)

    panel "Tickers" do
      table_for exchange.tickers.order(quote_currency: :asc) do
        column :id
        column :quote_currency
        column :base_currency
        column :last_24h_volume
        column :bid_price
        column :ask_price
      end
    end
  end
end
