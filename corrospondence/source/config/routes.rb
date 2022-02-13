require_relative './secure_api.rb'

Rails.application.routes.draw do
  scope "with_auth", constraints: SecureApi.new do
    post '/oauths/token', to: 'oauths#token'

    resources :oauths

    resources :forums do
      resources :conversations
    end
  end

  resources :forums do
    resources :conversations
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
