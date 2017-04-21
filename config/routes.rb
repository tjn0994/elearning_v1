Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  #scope "(:locale)", locale: /en|vi|ja/ do
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  mount ActionCable.server => '/cable'

  get 'home' => 'static_pages#home'

  namespace :students do
    resources :users
    resources :user_courses
    resources :courses do
      resources :lessons do
        resources :exams
      end
    end
  end

  namespace :teachers do
    resources :users
    resources :courses do
      resources :lessons do
        resources :questions
        resources :time_for_exams
      end
    end
  end

  namespace :admins do
    resources :users
    resources :categories do
      resources :types
    end
    resources :courses
    resources :set_status_courses, only: :index
  end

  namespace :publish do
    resources :posts do
      resources :comments
    end
    resources :rooms
  end

  namespace :download do
    resources :file_pdfs
  end


    # resources :workspaces do
    #   resource :user_workspaces, except: [:show]
    # end
end
