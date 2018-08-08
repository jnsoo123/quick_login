Rails.application.routes.draw do
  mount QuickLogin::Engine => "/quick_login"

  root to: 'home#index'
end
