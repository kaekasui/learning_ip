LearningIp::Application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'users/profile' => 'users/registrations#show'
    get 'users/email' => 'users/registrations#email'
    post 'users/send_email' => 'users/registrations#send_email'
    get 'users/name' => 'users/registrations#name'
    post 'users/update_name' => 'users/registrations#update_name'
    delete 'users/disconnect/:provider' => 'users/omniauth_callbacks#disconnect', as: 'disconnect_omniauth_provider'
    get 'users/code-:code' => 'users/registrations#update_email', as: "update_users_email"
  end

  namespace :admin do
    root 'dashboard#index'
    resources :categories, except: [:show]
    resources :sections
  end
end
