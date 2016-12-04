require 'sinatra'
require 'rack/ssl'
require 'pony'

class SDWeb < Sinatra::Base
  set :port, 8080
  use Rack::SSL if(ENV['ENV'] == 'production')
  set :bind, '0.0.0.0'
  set :public_folder, 'public'

  post '/mail/send' do
    if(params['email'] && params['name'] && params['subject'] && params['message'])
      from = "#{params['name']}<#{params['email']}>"
      Pony.mail(to: "inquiry@sittingduckads.com", from: from, subject: params['subject'], body: params['message'],
        via: :smtp,
        via_options: {
          :address        => 'email-smtp.us-west-2.amazonaws.com',
          :port           => 587,
          :user_name      => ENV['SD_SMTP_USER'],
          :password       => ENV['SD_SMTP_PASS'],
          :authentication => :login, # :plain, :login, :cram_md5, no auth by default
          :enable_starttls_auto => true,
          :domain         => "sittingducksads.com" # the HELO domain provided by the client to the server
        }
      )
    end
  end

  get '/?' do
    send_file File.join(settings.public_folder, 'index.html')
  end

  not_found do
    'Page not found.'
  end

  run! if app_file == $0
end