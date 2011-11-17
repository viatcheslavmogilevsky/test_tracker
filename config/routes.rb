TestTracker::Application.routes.draw do
  resources :comments

  resources :projects do
  	resources :tasks	
  end

  resources :sub_tasks

  devise_for :users
  
  resources :accounts

  root :to => "projects#index"
 
end
