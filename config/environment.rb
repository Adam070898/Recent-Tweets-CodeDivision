# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

require 'byebug'

enable :sessions

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')



# Twitter API Configuration
require 'twitter'
$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = WHOOPS
  config.consumer_secret     = UH OH
  config.access_token        = WOAH THERE
  config.access_token_secret = NOPE
end

# Hope this works
# def collect_with_max_id(collection=[], max_id=nil, &block)
#   response = yield(max_id)
#   collection += response
#   response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
# end

# def client.get_ten_tweets(user)
#   collect_with_max_id do |max_id|
#     options = {count: 10, include_rts: true}
#     options[:max_id] = max_id unless max_id.nil?
#     user_timeline(user, options)
#   end
# end
