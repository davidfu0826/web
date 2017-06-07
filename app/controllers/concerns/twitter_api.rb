module TwitterAPI
  def self.auth
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_secret
    end
    client
  end

  def self.embed_timeline(hide_media: true)
    embed = []
    client = auth
    timeline(client).each do |t|
      embed << client.oembed(t.id, hide_media: hide_media)
    end

    embed
  end

  def self.timeline(client, count: 3)
    client.user_timeline('Teknologkaren', count: count)
  end
end
