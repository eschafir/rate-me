require 'sinatra/base'
require 'sinatra/activerecord'
# require './models/note.rb' # your models
# require 'json' #json support

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
    set :database, 'sqlite:///test.db'
  end

  get '/' do
    File.read(File.join('public', 'index.html'))
  end

end
