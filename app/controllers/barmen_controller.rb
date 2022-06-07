class BarmenController < ApplicationController
    def personalArea 
        if(!(barman_signed_in?) || drinker_signed_in?)
            redirect_to "/"
        end
    end 

    def new 
        if drinker_signed_in?
            redirect_to bars_path
        end 
    end 
end 