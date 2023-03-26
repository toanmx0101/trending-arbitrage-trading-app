require "application_system_test_case"

class TickerPairsTest < ApplicationSystemTestCase
  setup do
    @ticker_pair = ticker_pairs(:one)
  end

  test "visiting the index" do
    visit ticker_pairs_url
    assert_selector "h1", text: "Ticker pairs"
  end

  test "should create ticker pair" do
    visit ticker_pairs_url
    click_on "New ticker pair"

    fill_in "Currency", with: @ticker_pair.currency_id
    fill_in "First ticker", with: @ticker_pair.first_ticker_id
    fill_in "Scheduler", with: @ticker_pair.scheduler
    fill_in "Second ticker", with: @ticker_pair.second_ticker_id
    fill_in "Tele channel", with: @ticker_pair.tele_channel_id
    fill_in "User", with: @ticker_pair.user_id
    click_on "Create Ticker pair"

    assert_text "Ticker pair was successfully created"
    click_on "Back"
  end

  test "should update Ticker pair" do
    visit ticker_pair_url(@ticker_pair)
    click_on "Edit this ticker pair", match: :first

    fill_in "Currency", with: @ticker_pair.currency_id
    fill_in "First ticker", with: @ticker_pair.first_ticker_id
    fill_in "Scheduler", with: @ticker_pair.scheduler
    fill_in "Second ticker", with: @ticker_pair.second_ticker_id
    fill_in "Tele channel", with: @ticker_pair.tele_channel_id
    fill_in "User", with: @ticker_pair.user_id
    click_on "Update Ticker pair"

    assert_text "Ticker pair was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticker pair" do
    visit ticker_pair_url(@ticker_pair)
    click_on "Destroy this ticker pair", match: :first

    assert_text "Ticker pair was successfully destroyed"
  end
end
