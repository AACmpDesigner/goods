Rails.application.routes.draw do
  root 'revenue#revenue'
  resources :sales, only: :index
  resources :goods
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      sessions: 'api/devise_token_auth/sessions'
    }
    resources :goods do
      member do
        get 'sales'
        get 'sales/:sale_id', to: 'goods#sale'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
