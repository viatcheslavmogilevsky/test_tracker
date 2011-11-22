TestTracker::Application.routes.draw do
  resources :comments

  resources :projects do
  	resources :tasks	
  end

  resources :sub_tasks

  devise_for :users
  
  resources :accounts do
  	member do
  		post 'send_request'
  		put	'accept_request'
  		delete 'reject_request'
  	end
  end

  root :to => "projects#index"
 
end
