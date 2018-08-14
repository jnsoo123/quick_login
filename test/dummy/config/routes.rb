Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  mount QuickLogin::Engine => "/quick_login"
end
