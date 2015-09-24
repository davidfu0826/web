class TweetsController < ApplicationController
  layout false

  def index
    cache_key = %w(views v1 tweets_index)
    @tweets = load_tweets unless Rails.cache.read(cache_key)
  end

  private

  def load_tweets
    TwitterAPI.get_tweets('Teknologkaren OR #tlth').take(3)
  end
end
