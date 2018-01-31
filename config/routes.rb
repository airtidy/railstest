Rails.application.routes.draw do


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :rankings do
    member do
      post :vote_up
      post :vote_down
    end
  end

  root :to => "pages#index"

end
