Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :documents, only: [:index, :create]
      resources :uploads, only: :create
    end
  end
end
