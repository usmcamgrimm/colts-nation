Rails.application.routes.draw do
  root "players#index"
  get "players" => "players#index"
  get "players/:id" => "players#show", as: "player"
  get "players/:id/edit" => "players#edit", as: "edit_player"
  get "schedule" => "schedule#index"
  patch "players/:id" => "players#update"
end
