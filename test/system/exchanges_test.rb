require "application_system_test_case"

class ExchangesTest < ApplicationSystemTestCase
  setup do
    @exchange = exchanges(:one)
  end

  test "visiting the index" do
    visit exchanges_url
    assert_selector "h1", text: "Exchanges"
  end

  test "should create exchange" do
    visit exchanges_url
    click_on "New exchange"

    fill_in "Description", with: @exchange.description
    fill_in "Name", with: @exchange.name
    click_on "Create Exchange"

    assert_text "Exchange was successfully created"
    click_on "Back"
  end

  test "should update Exchange" do
    visit exchange_url(@exchange)
    click_on "Edit this exchange", match: :first

    fill_in "Description", with: @exchange.description
    fill_in "Name", with: @exchange.name
    click_on "Update Exchange"

    assert_text "Exchange was successfully updated"
    click_on "Back"
  end

  test "should destroy Exchange" do
    visit exchange_url(@exchange)
    click_on "Destroy this exchange", match: :first

    assert_text "Exchange was successfully destroyed"
  end
end
