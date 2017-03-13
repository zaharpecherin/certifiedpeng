Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'  }
  devise_scope :user do
    get '/users', to: 'users/registrations#new'
  end

  resources :subscribers, only: [:new, :create]
  post '/stripe/webhooks', to: "stripe#webhooks"

  root to: 'site#index', as: :root
  get '/dashboard' => 'site#dashboard', as: :dashboard
  get '/like-button/:product_name' => 'site#product_name'
  get '/like' => 'site#like'
  get '/page-like-count' => 'site#page_like_count'
  get '/category/:name' => 'site#category', as: :category
  get '/contact-us' => 'site#contact_us', as: :contact_us
  post '/send-email' => 'site#sent_email', as: :sent_email
  get '/my-tags' => 'site#user_tags', as: :user_tags

end
