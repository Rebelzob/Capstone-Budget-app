Rails.application.routes.draw do
  devise_for :users
  root to: "splash_screen#index"

  resources :users, only: %i[show]

  resources :categories, only: %i[index show new create] do
    resources :expenses, only: %i[new create show]
  end
end
