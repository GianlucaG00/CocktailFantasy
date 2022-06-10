class Drinker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :email, :presence => { :message => "Devi inserire il nome"}
  validates :password, :presence => { :message => "Devi inserire il cognome"}
  validates_format_of :password, :with => /(.){6,}/, message: "Il formato degli ingredienti non è corretto! Devono essere separati dalla virgola senza spazi"

  has_many :reviews, dependent: :destroy
  has_many :chats, dependent: :destroy
end
