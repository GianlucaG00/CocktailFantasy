class BarmenController < ApplicationController
    def personalArea
        if drinker_signed_in?
            redirect_to bars_path
        end 
    end

    def sign_in
        if drinker_signed_in?
            redirect_to bars_path
        end
    end 

    def sign_up 
        if drinker_signed_in?
            redirect_to bars_path
        end
    end 

    
end