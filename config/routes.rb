Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :issues, only: [:index] , defaults: { format: "json" } do
        get :search , on: :collection, defaults: { format: "json" }
        get :get_parent , on: :collection, defaults: { format: "json" }
      end
    end
  end
  root to: "flows#index"
  resources :flows, only: [:new, :create, :edit, :update, :destroy]
end
