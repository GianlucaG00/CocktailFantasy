class Cocktail < ApplicationRecord

    # model validation
	validates :name, :presence => true    # uniqueness: { case_sensitive: false }
	validates :preparation, :presence => true

    def validate_description
    end  
end
