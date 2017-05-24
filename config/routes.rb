Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'  }
  devise_scope :user do
    get '/users', to: 'users/registrations#new'
    get '/users/sign_out', to: 'users/sessions#destroy'
  end

  resources :tags, only: [:index, :show, :create] do
    member do
      post '/rename-tagname', action: 'rename_tag'
    end
  end
  resources :purchases, only: [:create, :index] do
    collection do
      get '/confirm-purchase', action: 'confirm_purchase'
    end
  end
  resources :subscribers, only: [:new, :create]
  post '/stripe/webhooks', to: "stripe#webhooks"

  get '/merchandise', to: 'site#merchandise', as: :merchandise
  get '/dashboard', to: 'site#dashboard', as: :dashboard
  get '/category/:name', to: 'site#category', as: :category
  get '/contact-us', to: 'site#contact_us', as: :contact_us
  post '/send-email', to: 'site#send_email', as: :sent_email
  get '/terms', to: 'site#terms', as: :terms
  get '/about-us', to: 'site#about_us', as: :about_us

  get '/like-button/:tag_name',to: 'peng_widget#tag_name'
  get '/like', to: 'peng_widget#like'
  get '/page-like-count', to: 'peng_widget#page_like_count'

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  root to: 'site#index', as: :root
end
