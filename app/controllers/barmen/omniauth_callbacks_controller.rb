class Barmen::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        handle_auth "Google"
    end

    def facebook
        handle_auth "Github"
    end
    
    def handle_auth(kind)
        @barman = Barman.from_omniauth(request.env['omniauth.auth'])
        if(@barman.persisted?)
            set_flash_message(:notice, :success, :kind => kind) if is_navigational_format? 
            sign_in_and_redirect @barman, :event => :authentication
        else 
            session['devise.auth_data'] = request.env['omniauth.auth'].except('extra')
            redirect_to new_barman_registration_url
        end 
    end


    #def facebook 
    #    @barman = Barman.from_omniauth(request.env["omniauth.auth"])

    #    if @barman.persisted?
    #        sign_in_and_redirect @barman, :event => :authentication
    #        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    #    else
    #        session["devise.facebook_data"] = request.env["omniauth.auth"]
    #        redirect_to new_user_registration_url
    #    end
    #end 

    #def failure
    #    redirect_to root_path
    #end
end 