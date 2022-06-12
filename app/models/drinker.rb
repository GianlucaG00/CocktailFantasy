class Drinker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :presence => { :message => "Devi inserire una mail"}
  validates :password, :presence => { :message => "Devi inserire una password"}
  validates_format_of :password, :with => /(.){6,}/, message: "Il formato della password non è corretto! Deve contenere almeno 6 caratteri"
  validates :email, uniqueness: true

  has_many :reviews, dependent: :destroy
  has_many :chats, dependent: :destroy
end
