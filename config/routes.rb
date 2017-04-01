Rails.application.routes.draw do
  devise_for :users
  #scope "(:locale)", locale: /en|vi|ja/ do
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  namespace :students do
    resources :users
  end

  namespace :teachers do
    resources :users
  end

  namespace :admins do
    resources :users
  end


    # resources :workspaces do
    #   resource :user_workspaces, except: [:show]
    # end
end
