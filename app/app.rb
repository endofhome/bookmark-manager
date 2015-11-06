ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base

enable :sessions
set :session_secret, 'super secret'
register Sinatra::Flash
use Rack::MethodOverride
  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    redirect to('/links')
  end

  get '/links' do
    @links = Link.all
    erb :'/links/index'
  end

  get '/links/new' do
    erb :'/links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email],
                      password: params[:password],
                      password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/links')
    else
      error_string = ''
      @user.errors.each_value do |error|
        error_string << "#{error.first} "
      end
      flash.now[:notice] = error_string
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions/new' do
    if User.authenticate(params[:email],
                         params[:password])
      user = User.first(email: params[:email])
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.next[:notice] = 'Bad password, Yev!'
      redirect to('/sessions/new')
    end
  end

  delete '/sessions' do
    email = current_user.email
    session.clear
    flash.next[:notice] = "Goodbye, #{email}"
    redirect to('/sessions/new')
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
