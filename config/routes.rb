Rails.application.routes.draw do
  devise_for :users
  root 'events#index'

  resources :events
  resources :users, only: :show

  delete 'leave_event/', to: 'attendances#leave_event'
  post 'attend_event/', to: 'attendances#attend_event'
end