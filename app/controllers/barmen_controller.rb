class BarmenController < ApplicationController
    def personalArea 
        if(!(barman_signed_in?) || drinker_signed_in?)
            redirect_to "/"
        end
        @bars = Bar.where(barman_id: current_barman) # Bar posseduti dal Barman
    end 

    def new 
        if drinker_signed_in?
            redirect_to bars_path
        end 
    end 
end 