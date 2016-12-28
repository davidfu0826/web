class TweetsController < ApplicationController
  layout false

  def index
    cache_key = %w(views v1 tweets_index)
    @tweets = TwitterAPI.embed_timeline unless Rails.cache.read(cache_key)
  end
end
