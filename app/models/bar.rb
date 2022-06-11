class Bar < ApplicationRecord
	before_save :capitalize_title
	# ASSOCIATIONS
	belongs_to :barman
	has_many :cocktails, dependent: :destroy
	has_many :reviews, dependent: :destroy
	has_many :chats, dependent: :destroy

    #  model validation per i BAR 
	validates :name, :presence => true, uniqueness: { case_sensitive: false }
	validates :description, :presence => true
	validates :tel, :presence => true
	validates_format_of :tel, :with => /[0-9]{9,15}/, message: "Inserisci un recapito telefonico valido"
	validates :address, :presence => true

	# funzione per la ricerca tramite nome nella pagina dei Bar
	def self.search(name)
		if name
			where(["name LIKE ?","%#{name}%"])
		else
			all
		end
	end 

	def capitalize_title
        self.name = self.name.split(/\s+/).map(&:downcase).
          map(&:capitalize).join(' ')
    end

	def avg_reviews
		sum = 0
		self.reviews.each do |review|
			sum = sum + review.potatoes
		end
		if self.reviews.count>0
			return sum/self.reviews.count
		else
			return "--"
		end
	end
end
