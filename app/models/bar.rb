class Bar < ApplicationRecord
     # model validation per i BAR 
	validates :name, :presence => true    # uniqueness: { case_sensitive: false }
	validates :description, :presence => true
end
