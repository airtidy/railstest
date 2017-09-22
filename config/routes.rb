Rails.application.routes.draw do


  #mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  
  root :to => "pages#index"

  post 'ranking/edit'
  get 'ranking/view'

end
