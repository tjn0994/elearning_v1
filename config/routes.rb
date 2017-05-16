Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  #scope "(:locale)", locale: /en|vi|ja/ do
  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end
  root 'static_pages#home'
  # mount ActionCable.server => '/cable'

  get 'home' => 'static_pages#home'
  resources :register_courses, only: [:index, :show]

  namespace :members do
    root 'static_pages#home'
    resources :users do
      resources :posts do
        resources :comments
      end
    end
    resources :user_courses
    resources :courses do
      resources :lessons do
        resources :exams
      end
    end
    resources :activities
    resource :user_settings, only: :show
  end

  namespace :teachers do
    root 'courses#index'
    resources :users, only: [:show, :edit, :update]
    resources :courses do
      resources :lessons do
        resources :questions
        resources :time_for_exams
      end
      resources :user_courses,  only: [:index, :create]
      resource :user_courses, only: :destroy
      resources :register_courses
    end
    resource :user_settings, only: :show
  end

  namespace :admins do
    resources :users
    resources :categories do
      resources :types
    end
    resources :courses
    resources :set_status_courses, only: :index
    resource :user_settings, only: :show
  end

  namespace :publish do
    resources :posts do
      resources :comments
    end
    resources :rooms
  end

  # namespace :member do
  #   resources :posts do
  #     resources :comments
  #   end
  # end


    # resources :workspaces do
    #   resource :user_workspaces, except: [:show]
    # end
end
