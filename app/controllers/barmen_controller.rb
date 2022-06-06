class BarmenController < ApplicationController
    def personalArea 
        if(!(barman_signed_in?))
            redirect_to "/"
        end
    end 
end 