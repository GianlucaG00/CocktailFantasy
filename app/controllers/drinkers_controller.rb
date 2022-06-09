class DrinkersController < ApplicationController
    def personalArea 
        if(!(drinker_signed_in?) || barman_signed_in?)
            redirect_to "/"
        else
            @bars = Bar.all
            drinker_id = current_drinker.id
            @subscriptions = Chat.where(drinker_id: drinker_id )
            @reviews = Review.where(drinker_id: drinker_id)
        end
    end 

    def subscribe # Effettua l'iscrizione
        bar_id = params[:bar]
        drinker_id = current_drinker.id
        @drinker = Drinker.find(drinker_id)
        @bar = Bar.find(bar_id) 
        # nel caso in cui il Drinker sia già registrato per quel Bar
        if(Chat.find_by(drinker_id: drinker_id, bar_id: bar_id))
            flash[:message] = "Risulti già iscritto per #{@bar.name}"
        else
            @chat = Chat.new()
            @chat.bar = @bar
            @chat.drinker = @drinker
            @chat.save
            flash[:notice] = "Iscrizione al #{@bar.name} avvenuta con successo"
        end
        redirect_to drinkers_personalArea_path
    end 

    def unsubscribe # Annulla l'iscrizione
        bar_id = params[:bar_id]
        drinker_id = current_drinker.id
        puts "-------------------------------------"
        puts current_drinker.id
        puts bar_id
        puts Chat.where(bar_id: bar_id, drinker_id: drinker_id)
        puts "-------------------------------------"
        @chat = Chat.find_by(bar_id: bar_id, drinker_id: drinker_id)
        @chat.destroy
        redirect_to drinkers_personalArea_path
         
    end 


    def verify
        code = params[:code] #codice inviato dall'utente
        puts code
        #response = Searcher.search_cocktail(name)

        api_key = "5305253621:AAE9ff-75kqLnlyCiIpyXH1Dso69wvD2vDE"
        response = HTTP.get("https://api.telegram.org/bot#{api_key}/getUpdates")
        res = JSON.parse(response.body)
        begin
            data  = res["drinks"][0]

            @id_drink = data["idDrink"]
            @drink_name = data["strDrink"]
            @drink_img = data["strDrinkThumb"]
            @alcholic = data["strAlcoholic"]
            @glass = data["strGlass"]
            @instructionsIT = data["strInstructionsIT"]
            
            @ing1 = data["strIngredient1"]
            @ing2 = data["strIngredient2"]
            @ing3 = data["strIngredient3"]
            @ing4 = data["strIngredient4"]
            @ing5 = data["strIngredient5"]
            @ing6 = data["strIngredient6"]
            @ing7 = data["strIngredient7"]
            @ing8 = data["strIngredient8"]
            @ing9 = data["strIngredient9"]
            @ing10 = data["strIngredient10"]
            @ing11 = data["strIngredient11"]
            @ing12 = data["strIngredient12"]
            @ing13 = data["strIngredient13"]
            @ing14 = data["strIngredient14"]
            @ing15 = data["strIngredient15"]


            session[:found] = true; 
            session[:id_drink] = @id_drink
            session[:drink_name] = @drink_name
            session[:drink_img] = @drink_img
            session[:alcholic] = @alcholic
            session[:glass] = @glass
            session[:instructionsIT] = @instructionsIT

            # parametri passati tramite URL: 
            # redirect_to :controller => 'cocktails', :action => 'new', :id_drink => @id_drink, :drink_name => @drink_name, :drink_img => @drink_img, :instructions => @instructions, :found => true

            redirect_to :controller => 'cocktails', :action => 'new'

        rescue => exception 
            session[:found] = false
            redirect_to :controller => 'cocktails', :action => 'new'
        end
    end
    
end 