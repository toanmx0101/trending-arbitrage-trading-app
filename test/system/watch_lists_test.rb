# frozen_string_literal: true

require 'application_system_test_case'

class WatchListsTest < ApplicationSystemTestCase
  setup do
    @watch_list = watch_lists(:one)
  end

  test 'visiting the index' do
    visit watch_lists_url
    assert_selector 'h1', text: 'Watch lists'
  end

  test 'should create watch list' do
    visit watch_lists_url
    click_on 'New watch list'

    fill_in 'Currency', with: @watch_list.currency_id
    fill_in 'Schedule', with: @watch_list.schedule
    fill_in 'User', with: @watch_list.user_id
    click_on 'Create Watch list'

    assert_text 'Watch list was successfully created'
    click_on 'Back'
  end

  test 'should update Watch list' do
    visit watch_list_url(@watch_list)
    click_on 'Edit this watch list', match: :first

    fill_in 'Currency', with: @watch_list.currency_id
    fill_in 'Schedule', with: @watch_list.schedule
    fill_in 'User', with: @watch_list.user_id
    click_on 'Update Watch list'

    assert_text 'Watch list was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Watch list' do
    visit watch_list_url(@watch_list)
    click_on 'Destroy this watch list', match: :first

    assert_text 'Watch list was successfully destroyed'
  end
end
