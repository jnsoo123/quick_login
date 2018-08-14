QuickLogin::Engine.routes.draw do
  get '/login', to: 'quick_login#login', as: :login
end
