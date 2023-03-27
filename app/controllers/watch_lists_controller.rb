class WatchListsController < InheritedResources::Base

  private

    def watch_list_params
      params.require(:watch_list).permit(:currency_id, :user_id, :schedule)
    end

end
