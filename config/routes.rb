Rails.application.routes.draw do
  # トップ画面
  root 'top#index'

  # ログイン／ログアウト
  match '/login', to: 'login#login', via: 'post'
  match '/logout', to: 'login#logout', via: 'delete'

  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # ユーザー登録関連
  match '/users/new', to: 'users#new', via: 'get'
  match '/users/new', to: 'users#create', via: 'post'
end
