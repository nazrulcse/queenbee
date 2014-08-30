require 'api_constraints'

Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :orders, only: [:index, :show, :create] do
      	get :search, on: :collection
      end
    end
  end

  resources :applications, only: [:index, :show]
  resources :orders,       only: [:index, :show] do
    get 'import', on: :collection
    post 'process_import', on: :collection
  end

  root 'orders#index'

end
