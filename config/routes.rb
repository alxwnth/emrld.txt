Rails.application.routes.draw do

  resources :tasks

  root "tasks#index"

  post "tasks/:id/toggle", to: "tasks#toggle"

end
