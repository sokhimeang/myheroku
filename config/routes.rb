Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  scope "(:locale)", locale: /en|vi/ do
  root "schedules#index"
  get "static_pages/contact"
  get "static_pages/notice"
  resources :subjects do
    collection do
      post "add"
      post "remove"
    end
  end
  resources :rooms
  resources :schedules
  resources :users
  resources :feedbacks
  end

end
