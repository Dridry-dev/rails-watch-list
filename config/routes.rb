Rails.application.routes.draw do
  get 'reviews/create'
  get 'reviews/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # En tant qu’utilisateur, je peux créer une liste de films.
  # En tant qu’utilisateur, je peux voir les détails d’une liste de films.
  # En tant qu’utilisateur, je peux marquer (bookmark) un film dans une liste de films.
  # En tant qu’utilisateur, je peux détruire un bookmark.

  root to: 'lists#index'
  resources :lists, except: %i[edit update] do
    resources :bookmarks, only: %i[new create]
    resources :reviews, only: :create
  end
  resources :bookmarks, only: :destroy
  resources :reviews, only: :destroy
end
