Rails.application.routes.draw do
  root "players#index"

  resources :players, only: [ :index, :show ]
  get "schedule" => "schedule#index"
end
