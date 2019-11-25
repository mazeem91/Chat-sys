Rails.application.routes.draw do
  get "applications/" => "applications#index"
  post "applications/" => "applications#create"
  get "applications/:token" => "applications#show"
  put "applications/:token/" => "applications#update"
  delete "applications/:token/" => "applications#destroy"

  post "applications/:token/chats/" => "chats#create"
  get "applications/:token/chats/" => "chats#index"

  post "applications/:token/chats/:number/messages" => "messages#create"
  get "applications/:token/chats/:number/messages/" => "messages#index"
  get "applications/:token/chats/:number/messages/:query" => "messages#search"
end
