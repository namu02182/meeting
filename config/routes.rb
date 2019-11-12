Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  # root 'posts#index'
  #루트 설정을 조건을 걸면 애니로그인 에러가 뜸.
  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  get 'friends/become_friends/:id' => 'friends#become_friends', as: :friends
  get 'likes/start_love/:host_id/:id' => 'likes#start_love', as: :likes
  resources :posts, :except => :create
  post 'posts/create/:id' => 'posts#create' , as: :create_posts
  # get "posts/index" => "posts#index"
  get 'posts/loundge/:id' => "posts#loundge", as: :loundge
  get "posts/new" => "posts#new"
  get "posts/:id/show" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  get "posts/:id/destroy" => "posts#destroy"
  get "posts/:post_id/likes" => "likes#create"
  
  post "posts/:post_id/comments" => "comments#create"
  delete "comments/:id" => "comments#destroy"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
