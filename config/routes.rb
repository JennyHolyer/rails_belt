Rails.application.routes.draw do
  get '/' => 'users#index'

  get '/ideas' => 'users#ideas'

  post '/register' => 'users#create_user'

  post '/users/login' => 'users#login'

  post '/post_idea' => 'users#create_idea'

  get '/ideas/:id' => 'users#detail'

  get '/user/:id' => 'users#user_profile'

  get '/delete/:id' => 'users#delete'

  post '/like_idea/:id' => 'users#like_idea'

  post '/unlike_idea/:id' => 'users#unlike_idea'

  get '/ideas/:id' => 'users#ideas_detail'




  post '/logout' => 'users#clearSession'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
