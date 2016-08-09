# Homepage (Root path)
get '/' do
  erb :index
end

# login
get '/login' do
  erb :'login/index'
end
# login/logout

get '/logout' do
  session[:current_user] = nil
  redirect '/'
end

get '/users' do
  login_check
  erb :'users/index'
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

# all songs pages
get '/songs' do
  login_check
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  login_check
  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id' do
  login_check
  @song = Song.find params[:id]
  erb :'songs/show'
end

# posts -----------------

post '/songs' do
  login_check
  @song = Songs.new(
  song_title: params[:song_title],
  author: params[:author],
  url: params[:url] ||= "Not on spotify, try Google!"
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

post '/users' do
  @user = User.new(
  username: params[:username],
  password: params[:password]
  )
  if @user.save
    session[:current_user] = @user.id
    redirect '/songs'
  else
    erb :'users/new'
  end
end

post '/login' do
  @user = User.find_by(username: params[:username], password: params[:password])
  if @user
    session[:current_user] = @user.id
    redirect '/songs'
  else
    erb :'login/index'
  end
end

#helpers

def logged_out?
  session[:current_user].nil?
end

def login_check
  redirect '/login' if logged_out?
end

 helpers do
  def current_user
    User.find(session[:current_user])
  end
end
