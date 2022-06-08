class Cocktail < ApplicationRecord
    belongs_to :bar

    # model validation per i COCKTAILS
	validates :name, :presence => true    # uniqueness: { case_sensitive: false }
	validates :preparation, :presence => true
    validates_format_of :ingredients, :with => /[\w]*[,]*/

    def validate_description
    end  
end
