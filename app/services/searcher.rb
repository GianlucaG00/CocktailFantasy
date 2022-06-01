require "http"

class Searcher 
    # metodo di istanza 
    def self.search_cocktail(name)
        # name è il nome del cocktail da cercare
        begin
            response = HTTP.timeout(7).get("http://www.thecocktaildb.com/api/json/v1/1/search.php?", :params => {:s => name})
        rescue => exception
            return false
        end
        puts response
        return true
    end 
end 