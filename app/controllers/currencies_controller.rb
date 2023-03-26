class CurrenciesController < InheritedResources::Base

  private

    def currency_params
      params.require(:currency).permit(:name, :symbol, :website, :description)
    end

end
