class Bar < ApplicationRecord
	# ASSOCIATIONS
	belongs_to :barman
	has_many :cocktails
	has_many :reviews
	has_many :chats

     # model validation per i BAR 
	validates :name, :presence => true, uniqueness: { case_sensitive: false }
	validates :description, :presence => true
	validates :tel, :presence => true
	validates :address, :presence => true
	validates_format_of :ingredients, :with => /[\w]*[,]*/ 
end
