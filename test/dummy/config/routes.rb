Rails.application.routes.draw do
  mount QuickLogin::Engine => '/quick_login'
  devise_for :users
  root to: 'home#index'
end
