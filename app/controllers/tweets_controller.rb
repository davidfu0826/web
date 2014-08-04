class TweetsController < ApplicationController
  before_action :load_tweets

  def tweets
    render partial: 'tweet', collection: @tweets
  end

  private

  def load_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
    @tweets = client.user_timeline[0..2]
  end

end
