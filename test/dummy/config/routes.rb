Rails.application.routes.draw do
  devise_for :users
  mount QuickLogin::Engine => "/quick_login"

  root to: 'home#index'
end
