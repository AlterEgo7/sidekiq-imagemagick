Rails.application.routes.draw do
  get 'images/upload'
  root 'images#upload'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
