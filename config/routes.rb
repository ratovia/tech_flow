Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :issues, only: [:index] , defaults: { format: "json" }
    end
  end
  root to: "flows#index"
  resources :flows, only: [:new, :create, :edit, :update]
end
