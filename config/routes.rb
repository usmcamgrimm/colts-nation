Rails.application.routes.draw do
  root "players#index"

  resources :players, only: [ :index, :show ]
  resources :seasons, only: [ :index ]
end
