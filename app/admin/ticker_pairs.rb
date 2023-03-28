ActiveAdmin.register TickerPair do
  permit_params :currency_id, :first_ticker_id, :second_ticker_id, :scheduler, :tele_channel_id, :user_id, :spread_threshold_alert

  form do |f|
    f.object.currency = Currency.find(params[:currency_id]) if params[:currency_id]
    f.inputs "TickerPair" do
      f.input :currency,
        label: "Currency",
        as: :searchable_select,
        ajax: {
          collection_name: :search_currency,
        }

      f.input :first_ticker,
        label: "First exchange",
        as: :searchable_select,
        ajax: {
          collection_name: :search_by_currency,
          params: {
            currency_id: params[:currency_id]
          }
        }
      f.input :second_ticker,
        label: "Second exchange",
        as: :searchable_select,
        ajax: {
          collection_name: :search_by_currency,
          params: {
            currency_id: params[:currency_id]
          }
        }
      f.input :spread_threshold_alert
      f.input :scheduler
      f.input :status
      f.input :tele_channel_id
      f.input :user_id, :input_html => { :value => current_user.id }, as: :hidden
    end

    f.actions
  end

  index do
    column :id
    column :currency do |resource|
      link_to "#{resource.currency.symbol} #{resource.first_ticker.exchange.name} vs #{resource.second_ticker.exchange.name}", resource.currency
    end

    column :first_exchange do |resource|
      link_to "#{resource.first_ticker.last_price}", resource.first_ticker.spot_trade_url
    end
    column :second_exchange do |resource|
      link_to "#{resource.second_ticker.last_price}", resource.second_ticker.spot_trade_url
    end

    column :scheduler
    column :status
    column :spread_threshold_alert
    column :spread do |resource|
      "#{resource.spread}%" if resource.spread
    end
    column :last_run_at

    actions
  end

  show do
    attributes_table do
      row :currency
      row :first_exchange do |resource|
        link_to resource.first_ticker.exchange.name, resource.first_ticker.exchange
      end

      row :second_exchange do |resource|
        link_to resource.second_ticker.exchange.name, resource.second_ticker.exchange
      end
      row :status
      row :scheduler
      row :tele_channel_id
      row :user
      row :scheduled_sidekiq_job_id
      row :spread_threshold_alert do |resource|
        "#{resource.spread_threshold_alert}%"
      end
      row :spread do |resource|
        "#{resource.spread}%" if resource.spread
      end
      row :last_run_at
      row :created_at
      row :updated_at
    end
  end

  action_item :run_watcher, only: :show, index: 0 do
    if resource.running?
      link_to "Stop watcher", stop_watcher_admin_ticker_pair_path(resource)
    else
      link_to "Run watcher", run_watcher_admin_ticker_pair_path(resource)
    end
  end

  member_action :run_watcher do
    resource.start!
    redirect_to admin_ticker_pair_path(resource)
  end

  member_action :stop_watcher do
    resource.stop!
    redirect_to admin_ticker_pair_path(resource)
  end
end
