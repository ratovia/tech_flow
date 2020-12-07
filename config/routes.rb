Rails.application.routes.draw do
  root to: 'flows#index'
  namespace :api do
    defaults format: :json do
      namespace :v1 do
        resources :issues, only: :index do
          collection do
            get :search
            get :get_parent
          end
        end
        resources :articles, only: :index
      end
    end
  end
  resources :flows, only: [:new, :create, :edit, :update, :destroy]
end
