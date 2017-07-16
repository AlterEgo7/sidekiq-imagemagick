Rails.application.routes.draw do
  get 'images/upload'
  post 'images/upload' => 'images#perform_upload'
  get 'images/download' => 'images#download'
  root 'images#upload'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
