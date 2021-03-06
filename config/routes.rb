Rails.application.routes.draw do
  # model relativo ai BAR
  resources :bars do
    resources :cocktails, only:[:new, :show, :create, :destroy]
    resources :reviews, only:[:new, :create, :destroy]
  end 

  root to: "bars#index"
  
  # relativo al model COCKTAILS
 

  # per la richiesta API di ricerca Cocktail
  get "/api", to: "api#trigger"

  # per le API di telegram 
  post "api/message", to: "api#message"

  # BARMAN
  get "/barmen/personalArea", to: "barmen#personalArea"
  delete "/barmen/bars/:id", to:"bars#destroy"

  # DRINKERS
  get "/drinkers/personalArea", to: "drinkers#personalArea"
  get "/drinkers/info", to: "drinkers#getkey" 
  post "/drinkers/subscribe", to: "drinkers#subscribe"
  get "/drinkers/personalArea/unsubscribe/:bar_id", to:"drinkers#unsubscribe"
  delete "/drinkers/bars/:id_bar/reviews/:id", to:"reviews#destroy"



  # gestione delle UTENZE
  devise_for :barmen, :controllers => { :omniauth_callbacks => "barmen/omniauth_callbacks"}
  devise_for :drinkers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
