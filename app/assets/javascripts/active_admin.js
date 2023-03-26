//= require active_admin/base
//= require activeadmin_addons/all
//= require active_admin/searchable_select

$(document).on('change', '#ticker_pair_currency_id', function() {
  var value = $(this).val();
  window.location.href = "/admin/ticker_pairs/new?currency_id=" + value
});