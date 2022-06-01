Rails.application.routes.draw do
  resources :bars

  devise_for :barmen, :controllers => { :omniauth_callbacks => "barmen/omniauth_callbacks"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
