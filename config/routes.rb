Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'  }

  root to: 'site#index', as: :root
  get '/dashboard' => 'site#dashboard', as: :dashboard
  get '/like-button/:product_name' => 'site#product_name'
  get '/like' => 'site#like'
  get '/page-like-count' => 'site#page_like_count'

end
