Rails.application.routes.draw do
  resources :abstrakte_abschlussarbeits
  get "registrations/new"
  get "registrations/create"
  resource :registration, only: %i[new create]
  resource :session
  resources :passwords, param: :token
  resources :konkrete_abschlussarbeits
  resources :students # Suche über GET /students?search_query=...

  resources :texts, only: [] do
    collection do
      get :analyze  
      post :analyze 
    end
  end
  
  # Chatbot Routes
  get 'chatbot', to: 'chatbot#index'
  post 'chatbot', to: 'chatbot#create'
  delete 'chatbot/clear_history', to: 'chatbot#clear_history'
  
  # Debug Route
  post 'test', to: 'simple_test#test'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
