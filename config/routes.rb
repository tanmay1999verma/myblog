Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
     resources :articles do
    resources :comments

    resources :likes, only: [:create, :destroy]
  end
  get '/user_report', to: 'user#report'
  get '/sorted_user_report', to: 'user#sorted_report'
  get '/user_reports', to: 'user#reports'
  get '/article_report', to: 'articles#report'
  resources :user
  get "users/deactivate/:id" ,as:"deactivate" , to: "user#deactivate"
  get '/user_profile', to: 'user#profile'
end