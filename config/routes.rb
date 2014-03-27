require 'api_constraints'

Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :orders do
      	get :search, on: :collection
      end
    end
  end

  resources :applications
  resources :orders, only: [:index, :show]

  root 'orders#index'

end
