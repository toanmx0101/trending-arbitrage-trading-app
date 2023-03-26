ActiveAdmin.register TickerPair do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :currency_id, :first_ticker_id, :second_ticker_id, :scheduler, :tele_channel_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:currency_id, :first_ticker_id, :second_ticker_id, :scheduler, :tele_channel_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  include Rails.application.routes.url_helpers

  form do |f|
    f.inputs "TickerPair" do

      f.input :currency,
                label: "Currency",
                as: :search_select,
                minimum_input_length: 0

      f.input :first_ticker,
              label: "First exhcange",
              as: :searchable_select,
              ajax: {
                collection_name: :search_by_currency,
                params: {
                  currency_id: params[:currency_id]
                }
              }
      f.input :second_ticker,
              label: "Second exhcange",
              as: :searchable_select,
              ajax: {
                collection_name: :search_by_currency,
                params: {
                  currency_id: params[:currency_id]
                }
              }
      f.input :scheduler
      f.input :tele_channel_id
      f.input :user_id, :input_html => { :value => current_user.id }, as: :hidden
      f.input :currency_id, :input_html => { :value => params[:currency_id] }, as: :hidden
    end

    f.actions
  end
end
