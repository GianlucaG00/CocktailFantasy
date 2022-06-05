Rails.application.routes.draw do
  # model relativo ai BAR
  resources :bars
  # relativo al model COCKTAILS
  resources :cocktails

  # per la richiesta API 
  get "/api", to: "api#trigger"
  # per le API di telegram 
  post "api/message", to: "api#message"

  # BARMAN
  get "/barmen/personalArea", to: "barmen#personalArea"

  # DRINKER
  get "/drinkers/personalArea", to: "drinkers#personalArea"



  # gestione delle UTENZE
  devise_for :barmen, :controllers => { :omniauth_callbacks => "barmen/omniauth_callbacks"}
  devise_for :drinkers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
