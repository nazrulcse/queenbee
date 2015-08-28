require 'api_constraints'

Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :applications, only: [:index, :show]
      resources :orders, only: [:index, :show, :create, :update] do
      	get :search, on: :collection
      end
    end
  end

  resources :applications
  resources :orders, only: [:index, :show] do
    collection do
      get  'import'
      post 'process_import'
    end
  end

  root 'orders#index'

end
