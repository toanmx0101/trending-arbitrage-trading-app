# frozen_string_literal: true

require 'test_helper'

class TickerPairsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticker_pair = ticker_pairs(:one)
  end

  test 'should get index' do
    get ticker_pairs_url
    assert_response :success
  end

  test 'should get new' do
    get new_ticker_pair_url
    assert_response :success
  end

  test 'should create ticker_pair' do
    assert_difference('TickerPair.count') do
      post ticker_pairs_url,
           params: { ticker_pair: { currency_id: @ticker_pair.currency_id, first_ticker_id: @ticker_pair.first_ticker_id,
                                    scheduler: @ticker_pair.scheduler, second_ticker_id: @ticker_pair.second_ticker_id, tele_channel_id: @ticker_pair.tele_channel_id, user_id: @ticker_pair.user_id } }
    end

    assert_redirected_to ticker_pair_url(TickerPair.last)
  end

  test 'should show ticker_pair' do
    get ticker_pair_url(@ticker_pair)
    assert_response :success
  end

  test 'should get edit' do
    get edit_ticker_pair_url(@ticker_pair)
    assert_response :success
  end

  test 'should update ticker_pair' do
    patch ticker_pair_url(@ticker_pair),
          params: { ticker_pair: { currency_id: @ticker_pair.currency_id, first_ticker_id: @ticker_pair.first_ticker_id,
                                   scheduler: @ticker_pair.scheduler, second_ticker_id: @ticker_pair.second_ticker_id, tele_channel_id: @ticker_pair.tele_channel_id, user_id: @ticker_pair.user_id } }
    assert_redirected_to ticker_pair_url(@ticker_pair)
  end

  test 'should destroy ticker_pair' do
    assert_difference('TickerPair.count', -1) do
      delete ticker_pair_url(@ticker_pair)
    end

    assert_redirected_to ticker_pairs_url
  end
end
