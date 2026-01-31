Rails.application.routes.draw do
  root "players#index"

  resources :players, only: [ :index, :show ]

  get "shedule" => "schedule#index"
end
