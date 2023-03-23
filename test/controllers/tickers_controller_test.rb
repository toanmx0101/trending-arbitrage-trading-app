require "test_helper"

class TickersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticker = tickers(:one)
  end

  test "should get index" do
    get tickers_url
    assert_response :success
  end

  test "should get new" do
    get new_ticker_url
    assert_response :success
  end

  test "should create ticker" do
    assert_difference("Ticker.count") do
      post tickers_url, params: { ticker: { ask_price: @ticker.ask_price, base_currency: @ticker.base_currency, bid_price: @ticker.bid_price, exchanges_id: @ticker.exchanges_id, last_24h_volume: @ticker.last_24h_volume, last_price: @ticker.last_price, quote_currency: @ticker.quote_currency } }
    end

    assert_redirected_to ticker_url(Ticker.last)
  end

  test "should show ticker" do
    get ticker_url(@ticker)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticker_url(@ticker)
    assert_response :success
  end

  test "should update ticker" do
    patch ticker_url(@ticker), params: { ticker: { ask_price: @ticker.ask_price, base_currency: @ticker.base_currency, bid_price: @ticker.bid_price, exchanges_id: @ticker.exchanges_id, last_24h_volume: @ticker.last_24h_volume, last_price: @ticker.last_price, quote_currency: @ticker.quote_currency } }
    assert_redirected_to ticker_url(@ticker)
  end

  test "should destroy ticker" do
    assert_difference("Ticker.count", -1) do
      delete ticker_url(@ticker)
    end

    assert_redirected_to tickers_url
  end
end
