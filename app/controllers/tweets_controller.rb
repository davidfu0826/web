class TweetsController < ApplicationController
  before_action :load_tweets

  def tweets
    render partial: 'tweet', collection: @tweets
  end

  private

  def load_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_secret
    end
    @tweets = client.search("Teknologkaren OR #tlth").take(3)
  end

end
