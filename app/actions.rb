# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Songs.all
  erb :'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end

post '/songs' do
  @song = Songs.new(
  song_title: params[:song_title],
  author: params[:author],
  url: params[:url] || "Not on spotify, try Google!"
  )
  if @song.save
    redirect '/songs'
  else 
    erb :'songs/new'
  end
end

get '/songs/:id' do
  @song = Songs.find params[:id]
  erb :'songs/show'
end
