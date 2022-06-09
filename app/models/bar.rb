class Bar < ApplicationRecord
	# ASSOCIATIONS
	belongs_to :barman
	has_many :cocktails, dependent: :destroy
	has_many :reviews, dependent: :destroy
	has_many :chats, dependent: :destroy

     # model validation per i BAR 
	validates :name, :presence => true, uniqueness: { case_sensitive: false }
	validates :description, :presence => true
	validates :tel, :presence => true
	validates_format_of :tel, :with => /[0-9]{9,15}/, message: "Inserisci un recapito telefonico valido"
	validates :address, :presence => true

	validates_format_of :ingredients, :with => /[\w]*[,]*/ 
end
