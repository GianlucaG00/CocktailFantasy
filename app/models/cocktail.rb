class Cocktail < ApplicationRecord
    before_save :capitalize_title

    belongs_to :bar

    # model validation per i COCKTAILS
	validates :name, :presence => { message: "Il nome del Cocktail non può essere vuoto!"}
	validates :preparation, :presence => {message: "La preparazione non può essere vuoto!"}
    validates :price, :presence => {message: "Devi specificare un prezzo!"}
    validates_format_of :ingredients, :with => /([a-z]*(,)*|())/i, message: "Il formato degli ingredienti non è corretto! Devono essere separati dalla virgola senza spazi"

    # Non possono esistere due tuple con stesso cocktail_name e stesso bar_id
    validates_uniqueness_of :name, scope: :bar_id, message: "Per questo menù esiste già un Cocktail con questo nome!"

    def capitalize_title
        self.name = self.name.split(/\s+/).map(&:downcase).
        map(&:capitalize).join(' ')
    end 
end
