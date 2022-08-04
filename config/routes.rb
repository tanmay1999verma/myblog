Rails.application.routes.draw do
  # devise_scope :user do
  #   # Redirests signing out users back to sign-in
  #   get "users", to: "devise/sessions#new"
  # end
  devise_for :users
  root "articles#index"
     resources :articles do
    resources :comments

    resources :likes, only: [:create, :destroy]
  end
  get '/user_report', to: 'user#report'#page where csv file is downloaded
  get '/sorted_user_report', to: 'user#sorted_report'
  get '/user_reports', to: 'user#reports'#report page
  get '/article_report', to: 'articles#report'
  resources :user
  get "users/deactivate/:id" ,as:"deactivate" , to: "user#deactivate"
  get '/user_profile', to: 'user#profile'
  get '/import', to: 'user#import'
  post '/import_users', to: 'user#import_users' do
    collection {post :import}
  end
end