class Cocktail < ApplicationRecord
    belongs_to :bar

    # model validation per i COCKTAILS
	validates :name, :presence => true    # uniqueness: { case_sensitive: false }
	validates :preparation, :presence => true

    def validate_description
    end  
end
