$LOAD_PATH.unshift File.dirname(__FILE__)
require_relative 'app'

run Sinatra::Application
