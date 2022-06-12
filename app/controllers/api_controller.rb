class ApiController < ApplicationController

    def trigger
        name = params[:cocktail_name] #nome del cocktail
        id_bar = params[:bar]
        puts id_bar
        puts name
        response = HTTP.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?", :params => {:s => name})
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
            
            session[:ing1] = @ing1
            session[:ing2] = @ing2
            session[:ing3] = @ing3
            session[:ing4] = @ing4
            session[:ing5] = @ing5
            session[:ing6] = @ing6
            session[:ing7] = @ing7
            session[:ing8] = @ing8
            session[:ing9] = @ing9
            session[:ing10] = @ing10
            session[:ing11] = @ing11
            session[:ing12] = @ing12
            session[:ing13] = @ing13
            session[:ing14] = @ing14
            session[:ing15] = @ing15
            # parametri passati tramite URL: 
            # redirect_to :controller => 'cocktails', :action => 'new', :id_drink => @id_drink, :drink_name => @drink_name, :drink_img => @drink_img, :instructions => @instructions, :found => true

            redirect_to "/bars/#{id_bar}/cocktails/new"

        rescue => exception 
            session[:found] = false
            redirect_to "/bars/#{id_bar}/cocktails/new"
            #redirect_to :controller => 'cocktails', :action => 'new'
        end
    end

    def message
        text = params[:messaggio]
        bar_id = params[:bar] #bar da cui proviene la comunicazione
        @bar = Bar.find(bar_id)
        text = 'Comunicazione da: ' + @bar.name + "\n" + text
        puts "------------------------------"
        puts text
        puts bar_id
        puts "------------------------------"
        api_key = "5305253621:AAE9ff-75kqLnlyCiIpyXH1Dso69wvD2vDE"
        barman_id = current_barman
        Chat.select(:drinker_id).where(bar_id: bar_id).each do |chat|
            chat_id = Drinker.select(:chat_id).find(chat.drinker_id).chat_id
            HTTParty.post("https://api.telegram.org/bot#{api_key}/sendMessage",
                headers: {
                    'Content-Type' => 'application/json'
                },
                body: {
                    chat_id: chat_id,
                    text: text
                }.to_json
            )
        end 
        @num_sub = Chat.where(bar_id: bar_id).size
        redirect_to barmen_personalArea_path, :notice => "Messaggio inviato correttamente ai tuoi #{@num_sub} iscritti"
    end
end
