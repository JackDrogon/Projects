#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'sinatra'

get '/' do
  content_type :txt
  'Welcome to HackerNews.'
end

## Blog
# @doc: list article
# redis list
get '/:year/:month/:day' do
  "#{params['year']}-#{params['month']}-#{params['day']}'s Articles."
end

# Use redis hash, mysql (with datetime author...)
get '/aritles/:name' do
  "You get artile #{params['name']}!"
end

get '/cateory' do
end

get '/rss' do
end

get '/login' do
end

post '/login' do
end

get '/logout' do
end

get '/api' do
end

get '/api/login' do
end

get '/api/logout' do
end
