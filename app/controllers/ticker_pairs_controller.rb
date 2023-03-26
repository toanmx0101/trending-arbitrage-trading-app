class TickerPairsController < InheritedResources::Base

  private

    def ticker_pair_params
      params.require(:ticker_pair).permit(:currency_id, :first_ticker_id, :second_ticker_id, :scheduler, :tele_channel_id, :user_id)
    end

end
