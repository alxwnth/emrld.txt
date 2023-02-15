Rails.application.routes.draw do

  resources :tasks

  root "tasks#index"

  post "tasks/:id/toggle", to: "tasks#toggle"
  get "tasklog", to: "tasks#tasklog"
  get "import", to: "tasks#import"
  get "export", to: "tasks#export"
  get "purge", to: "tasks#purge_completed"
  post "batch_add", to: "tasks#batch_add"

end
