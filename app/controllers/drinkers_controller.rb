class BarmenController < ApplicationController
    def personalArea
        if barman_signed_in?
            redirect_to bars_path
        end 
    end

    def sign_in
        if barman_signed_in?
            redirect_to bars_path
        end
    end 

    def sign_up 
        if barman_signed_in?
            redirect_to bars_path
        end
    end 
end