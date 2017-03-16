Rails.application.routes.draw do

  get 'errors/not_found'

  get 'errors/internal_server_error'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'  }
  devise_scope :user do
    get '/users', to: 'users/registrations#new'
  end

  resources :tags, only: [:index, :show] do
    collection do
      get '/tag-detaling/:tag/:url', action: 'tag_detailing', as: :tag_detaling, constraints: { url: /[A-Z]+[0-9\.]+/ }
    end
  end

  resources :subscribers, only: [:new, :create]
  post '/stripe/webhooks', to: "stripe#webhooks"

  get '/dashboard', to: 'site#dashboard', as: :dashboard
  get '/like-button/:tag_name',to: 'site#tag_name'
  get '/like', to: 'site#like'
  get '/page-like-count', to: 'site#page_like_count'
  get '/category/:name', to: 'site#category', as: :category
  get '/contact-us', to: 'site#contact_us', as: :contact_us
  post '/send-email', to: 'site#sent_email', as: :sent_email
  get '/terms', to: 'site#terms', as: :terms
  get '/about-us', to: 'site#about_us', as: :about_us

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  root to: 'site#index', as: :root
end
