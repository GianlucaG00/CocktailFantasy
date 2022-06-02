class ApiController < ApplicationController

    def trigger
        name = params[:cocktail_name] #nome del cocktail
        puts name
        #response = Searcher.search_cocktail(name)
        response = HTTP.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?", :params => {:s => name})
        res = JSON.parse(response.body)
        begin
            data  = res["drinks"][0]

            @id_drink = data["idDrink"]
            @drink_name = data["strDrink"]
            @drink_img = data["strDrinkThumb"]
            @alcholic = data["strAlcoholic"]
            @type = data["strGlass"]
            @instructions = data["strInstructionsIT"]
            
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
            redirect_to :controller => 'cocktails', :action => 'new', :method => :post, :id_drink => @id_drink, :drink_name => @drink_name, :drink_img => @drink_img, :instructions => @instructions, :found => true 
        rescue => exception 
            redirect_to :controller => 'cocktails', :action => 'new', :method => :post, :found => false
        end
    end
end
