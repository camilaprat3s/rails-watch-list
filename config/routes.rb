Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :lists do
    resources :bookmarks, only: [:new, :create]
  end

  # Adjust the route for the destroy action
  delete "/bookmarks/:id", to: "bookmarks#destroy", as: :bookmark

  # Set the root path to lists#index
  root to: "lists#index"
end
