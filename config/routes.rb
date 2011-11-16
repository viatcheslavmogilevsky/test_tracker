TestTracker::Application.routes.draw do
  resources :comments

  resources :projects

  resources :sub_tasks

  resources :tasks

  devise_for :users
  
  resources :accounts

  root :to => "projects#index"
 
end
