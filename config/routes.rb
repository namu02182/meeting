Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "posts#index"
  
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id/show" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  get "posts/:id/destroy" => "posts#destroy"
  
  get "posts/:post_id/likes" => "likes#create"
  
  post "posts/:post_id/comments" => "comments#create"
  delete "comments/:id" => "comments#destroy"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
