class TwitterUser < ActiveRecord::Base
  has_many :tweets
  def fetch_tweets!
    $client.user_timeline(self.username, count: 10).each do |tweet|
      self.tweets.create(text: tweet.text)
    end
  end

  def stale_tweets?
    return self.tweets.last.updated_at < (Time.now - 900)
  end

  def update_tweets!
    newtweets = $client.user_timeline(self.username, count: 10)
    counter = 0
    self.tweets.each do |tweet|
      tweet.text = newtweets[counter].text
      counter += 1
    end
  end
end
