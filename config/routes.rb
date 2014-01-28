LearningIp::Application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    delete 'users/disconnect/:provider' => 'users/omniauth_callbacks#disconnect', as: 'disconnect_omniauth_provider'
  end
end
