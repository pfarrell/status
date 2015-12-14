require './poster'
require 'twitter'
require 'httparty'
require 'byebug'

def format_tweet(tweet, key_name)
  status = Status.new
  status.name = "Twitter"
  html="<div style='background-color:#\"#{tweet.user.profile_background_color}\"'>
#{tweet.text}
  </div>
  "
  status.value[key_name] = html
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["STATUS_CONSUMER_KEY"]
  config.consumer_secret     = ENV["STATUS_CONSUMER_SECRET"]
  config.access_token        = ENV["STATUS_ACCESS_TOKEN"]
  config.access_token_secret = ENV["STATUS_ACCESS_TOKEN_SECRET"]
end

tweets = client.user_timeline("pfarrell")

status = Status.new
status.name = "Twitter"
status.value["latest tweet"] = tweets.last.text

byebug
p status.to_json

poster = Poster.new
poster.group = "pattest"
poster.statuses << format_tweet(tweets.last, "html_tweet")
#poster.statuses << status
poster.save



