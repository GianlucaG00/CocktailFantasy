class Bar < ApplicationRecord
	# ASSOCIATIONS
	belongs_to :barman
	has_many :cocktails
	has_many :reviews

     # model validation per i BAR 
	validates :name, :presence => true    # uniqueness: { case_sensitive: false }
	validates :description, :presence => true
end
