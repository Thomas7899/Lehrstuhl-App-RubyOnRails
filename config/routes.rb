# config/routes.rb
Rails.application.routes.draw do
  # ALLE generierten Routes entfernen:
  # get "chat_messages/index"     ❌ ENTFERNEN
  # get "chat_messages/create"    ❌ ENTFERNEN
  # get "chat_messages/show"      ❌ ENTFERNEN

  resources :abstrakte_abschlussarbeits
  get "registrations/new"
  get "registrations/create"
  resource :registration, only: %i[new create]
  resource :session
  resources :passwords, param: :token
  resources :konkrete_abschlussarbeits

  # KORRIGIERT: Nur Resource-Route für Chat Messages
  resources :chat_messages, only: [ :index, :create, :show ]

  resources :students

  resources :texts, only: [] do
    collection do
      get :analyze
      post :analyze
    end
  end

  # Chatbot Routes
  get "chatbot", to: "chatbot#index"
  post "chatbot", to: "chatbot#create"
  delete "chatbot/clear_history", to: "chatbot#clear_history"

  # Debug Route
  post "test", to: "simple_test#test"

  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
