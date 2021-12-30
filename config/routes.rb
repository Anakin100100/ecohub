Rails.application.routes.draw do
  resources :lists
  resources :ingredients
  resources :recipes
  resources :comments
  resources :posts  do
    member do
      post 'toggle_favorite', to: "posts#toggle_favorite"
    end
    resources :comments
  end
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "pages#home"
  get "/healthcheck" => 'health_and_monitoring#healthcheck'
  get "/user" => "posts#index", :as => :user_root
  get "/add_recipe_to_list" => 'recipes#add_recipe_to_list'
  get "/share_recipe" => 'recipes#share'
  get "/user_profile" => 'users#profile'
  get "/add_shared_recipe" => 'recipes#add_shared_recipe'
  get "/wasted_ingredients" => 'ingredients#wasted_ingredients'
end
