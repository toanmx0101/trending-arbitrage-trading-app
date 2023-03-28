ActiveAdmin.register WatchList do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :currency_id, :user_id, :schedule, :spread_threshold_alert
  #
  # or
  #
  # permit_params do
  #   permitted = [:currency_id, :user_id, :schedule]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
