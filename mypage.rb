require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'haml'
require 'json'


def get_json (url)
  JSON.parse RestClient.get url
end

def get_twits (query)
  twitter_response = get_json 'http://search.twitter.com/search.json?&q=' + query
  twitter_response["results"]
end

def get_gibberish_text (params)
  randomtext_response = get_json 'http://www.randomtext.me/api/gibberish/' + params
  randomtext_response["text_out"]
end

get '/' do
  @twitter_comments = get_twits '%23mypage'

  @first_random_paragraphs = get_gibberish_text 'p-3/10-50'
  @random_alert = get_gibberish_text 'p-1/10-10'
  @random_block_message = get_gibberish_text 'p-1/20-30'
  @last_random_paragraphs = get_gibberish_text 'p-3/10-50'

  haml :index
end