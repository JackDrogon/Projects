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
get '/articles/:name' do
  # articles/2015-05-20_hello.md
  article_name = "./articles/#{params[:name]}"
  if File.readable? article_name
    article = File.read article_name
    # FIXME: Here Document Problem
    <<-ARTICLE
    You get artile #{params['name']}!

    Article is:
    #{article}
    ARTICLE
  else
    "NOT_FOUND #{params['name']}"
  end
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
