require 'sinatra'
require 'rack/ssl'

class SDWeb < Sinatra::Base
  set :port, 8080
  use Rack::SSL if(ENV['ENV'] == 'production')
  set :bind, '0.0.0.0'
  set :public_folder, 'public'

  get '/?' do
    send_file File.join(settings.public_folder, 'index.html')
  end

  not_found do
    'Page not found.'
  end

  run! if app_file == $0
end