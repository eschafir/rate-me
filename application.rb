require 'sinatra/base'
require 'sinatra/activerecord'
require 'date'
require './models/event.rb' # your models
# require 'json' #json support
require './models/score.rb'
require './models/user.rb'

class MyApplication < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions


  #:nocov:
  configure :production,:staging do
    set :database, ENV['DATABASE_URL']
  end

  configure :development do
    set :database, 'sqlite:///dev.db'
  end
  #:nocov:

  configure :test do
    set :database, 'sqlite:///dev.db'
  end

  get '/' do
    erb :log_in
  end

  get '/new' do
    erb :event_new
  end

  post '/new' do
    user = session[:user]    
    name = params[:name]
    date = Date.parse(params[:date])
    event = Event.new
    event.name = name
    event.date = date
    event.user = user
    event.save
    @message = "Event created"
    @link = "Link to this event: http://safe-garden-4641.herokuapp.com/event/#{event.id}/rate"
    erb :operation_result
    
  end

  get '/events' do
    @list = Event.where(:user => session[:user])
    erb :event_list
  end

  get '/event/:id/rate' do
     event = Event.find(params[:id].to_i) 
     @event_name = event.name  
     erb :rate_event 
  end

  get '/event/:id/stats' do
   id = params[:id]
   event = Event.find(id)
   @name = event.name
   @date = event.date
   @positive = Score.where(:event_id => id, :rate => 'Positive').count
   @negative = Score.where(:event_id => id, :rate => 'Negative').count
   @neutral = Score.where(:event_id => id, :rate => 'Neutral').count
   erb :stats
  end

  get '/event/:id/comments' do |id|
     event = Event.find(id)
     event_id = event.id
     user = session[:user]
     @message = "View comments event #{event.name}"
     @name = event.name
     @list = Score.find_all_by_event_id(event_id)
     erb :event_comments
  end

  post '/event/:id/rate' do
       type_rate = params[:score]
       id= params[:id]
       score = Score.new
       score.event_id = id
       score.rate = type_rate
       score.comment = params[:comments]
       score.save!
       @message="Your score was sent. Thanks!"
       erb :score_sent
  end

  get '/sign_in' do
	erb :sign_in
  end

  get '/log_in' do
	erb :log_in
  end

  get '/main' do 
	erb :main_page
  end

  post '/main' do
      existe = false
      users = User.all
      users.each do |user|
         if user.username == params[:username]
            then existe = true
         end
      end
      if existe
         then erb :error_username_exists
      else
           user = User.new
                  user.name = params[:name]
           user.username = params[:username]
           user.password = params[:password]
           user.email = params[:email]
           user.save
           session[:user] = params[:username]
           erb :main_page  
      end
  end

  post '/login' do
      username_exist = false
      current_user = nil
      users = User.all
      users.each do |user|
         if user.username == params[:username] #primero verifico si el username existe
             username_exist = true             #si no existe, lanza error de usuario
             current_user = user
         end
      end
     
      if username_exist
            if current_user.password == params[:password] #si el username existe y es el
                  session[:user] = current_user.username
                  erb :main_page                          #password correcto, me lleva al
            else erb :error_password_wrong                #main page
            end                                           #si no es correcto, lanza error de
      else                                                #contraseña
            erb :error_username_dont_exists  
      end
 end
 

end
