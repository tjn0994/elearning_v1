Rails.application.routes.draw do
  devise_for :users
  #scope "(:locale)", locale: /en|vi|ja/ do
  root "static_pages#home"

  namespace :students do
    root "static_pages#home"
    resources :users
  end

  namespace :teachers do
    root "static_pages#home"
    resources :users
  end

  namespace :admins do
    root "static_pages#home"
    resources :users
  end


    # resources :workspaces do
    #   resource :user_workspaces, except: [:show]
    # end
end
