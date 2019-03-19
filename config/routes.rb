Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
	root to: "static_pages#home"
	get "/login", to: "sessions#new"
	post "/login", to: "sessions#create"
	delete "/logout", to: "sessions#destroy"
	patch "/insert/:id", to: "detail_movies#insert", as: "insert"
	resources :genre_movies
	resources :year_movies
	resources :detail_movies
	resources :watch_movies
	resources :searchs
	resources :comments
	resources :users
	resources :movie_carts
	namespace :admin do
		get "/index", to: "movies#index"
		patch "/update_movie/:id", to: "movies#update_movie", as: "update_movie"
		get "/admin/episodes/new/:id", to: "episodes#new", as: "create_eipsode"
    patch "/update_episode/:id", to: "episodes#update_episode", as: "update_episode"
	  resources :movies
	  resources :users
	  resources :episodes
	end
	namespace :post do
		get "/index", to: "movies#index"
		get "/post/episodes/new/:id", to: "episodes#new", as: "create_eipsode"
	  resources :movies
	  resources :episodes
	end
  end
end
