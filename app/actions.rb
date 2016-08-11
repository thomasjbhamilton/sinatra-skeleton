
# before methods

before '/songs*' do
  login_check
end

before '/reviews*' do
  login_check
end


# Homepage (Root path)

get '/' do
  erb :index
end

# login

get '/login' do
  erb :'login/index'
end

get '/logout' do
  session[:current_user] = nil
  redirect '/'
end

# users

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
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

# posts -----------------

post '/songs' do
  @song = Song.new(
  song_title: params[:song_title],
  author: params[:author],
  url: params[:url],
  user_id: session[:current_user]
  )
  binding.pry

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
    session[:login_error] = "Wrong email or password! Try again."
    erb :'login/index'
  end
end

post '/songs/votes/:id' do
  @song = Song.find params[:id]
  @user = User.find session[:current_user]
  Vote.create(song: @song, user: @user)
  redirect '/songs'
end

post '/reviews/:id' do
  @song = Song.find params[:id]
  @user = User.find session[:current_user]
  Review.create(song: @song, user: @user, comment: params[:comment], rating: params[:rating])
  redirect "songs/#{params[:id]}"
end

post '/reviews/destroy/:id' do
  review = Review.find(params[:id])
  review.destroy
  redirect "songs/#{params[:song_id]}"
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

  def all_reviews
    Review.all
  end
end
