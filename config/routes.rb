Rails.application.routes.draw do
  devise_for :users

   resources :books do
     resource :favorites, only: [:create, :destroy]
     resources :book_comments, only: [:create, :destroy]
   end

    resources :users do
     resource :relationships, only: [:create, :destroy]
     get 'followings' => 'relationships#followings', as: 'followings'
     get 'followers' => 'relationships#followers', as: 'followers'
    end
  # 例えば get '/users/:id/followings' => 'users#followings', as: 'followings' として、usersコントローラで実装することもできます。

   root to: 'homes#top'
  get "/home/about" => "homes#about"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
