Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # En tant qu’utilisateur, je peux créer une liste de films.
  # En tant qu’utilisateur, je peux voir les détails d’une liste de films.
  # En tant qu’utilisateur, je peux marquer (bookmark) un film dans une liste de films.
  # En tant qu’utilisateur, je peux détruire un bookmark.

  root 'lists#index'
  resources :lists, only: %i[index new create show] do
    # resources :bookmarks, only: %i[new create destroy]
    # Create
    get 'bookmarks/new', to: 'bookmarks#new', as: :new_bookmark
    post 'bookmarks', to: 'bookmarks#create'
  end
  delete 'bookmarks/:id', to: 'bookmarks#destroy', as: :destroy
end
