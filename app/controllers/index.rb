get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.where(username: params[:username]).first

  if @user == nil
    @user = TwitterUser.create(username: params[:username])
  end

  if @user.tweets.empty?
    $client.user_timeline(params[:username], count: 10).each do |tweet|
      @user.tweets.create(text: tweet.text)
    end
  end

  if @user.tweets.last.updated_at < (Time.now - 900) # 15 mins
    newtweets = $client.user_timeline(params[:username], count: 10)
    counter = 0
    @user.tweets.each do |tweet|
      tweet.text = newtweets[counter].text
      counter += 1
    end
  end


  @tweets = @user.tweets
  @counter = 0
  erb :recenttweets
end