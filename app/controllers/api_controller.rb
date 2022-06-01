class ApiController < ApplicationController

    def trigger
        name = params[:name] #nome del cocktail
        if Searcher.search_cocktail(name)
            @message = 'Success'
        else
            @message = 'Failed'
        end 
    end 
end
