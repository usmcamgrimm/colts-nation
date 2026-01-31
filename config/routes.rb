Rails.application.routes.draw do
  root "players#idex"

  resources :players, only: [ :index, :show ]

  get "shedule" => "schedule#index"
end
