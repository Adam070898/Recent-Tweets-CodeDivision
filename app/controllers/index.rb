get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.where(username: params[:username]).first
  @user == nil ? @user = TwitterUser.create(username: params[:username]) : nil
  if ( @user.tweets.empty? || @user.stale_tweets? )
    @tweets = @user.tweets
    erb :loading
  else
    @tweets = @user.tweets; @counter = 0
    erb :recenttweets
  end
end

get '/data/:username' do
  @user = TwitterUser.where(username: params[:username]).first
  if @user.tweets.empty? then @user.fetch_tweets! end
  if @user.stale_tweets? then @user.update_tweets! end
  @tweets = @user.tweets; @counter = 0
  erb :recenttweets
end