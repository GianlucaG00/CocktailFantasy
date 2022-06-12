class Barman < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  
  # ASSOCIATIONS
  has_many :bars, dependent: :destroy

  validates :name, :presence => { :message => "Devi inserire il nome"}
  validates :surname, :presence => { :message => "Devi inserire il cognome"}
  validates :email, :presence => { :message => "Devi inserire la mail"}
  validates :email, uniqueness: true
  validates_format_of :password, :with => /(.){6,}/, message: "Il formato della password non è corretto! Almeno 6 caratteri"


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |barman|
      barman.email = auth.info.email
      barman.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |barman|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        barman.email = data["email"] if barman.email.blank?
      end
    end
  end 
end
