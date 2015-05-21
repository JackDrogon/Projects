#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'pp'

require 'sinatra'
require 'redis'
require 'rdiscount'

require_relative 'app_config'

# TODO: Add logger

redis = Redis.new RedisServerOption

# TODO: add proc, when value is nil, use proc to generate value
def get_key(key)
end

get '/' do
  content_type :txt
  'Welcome to HackerNews.'
end

## Blog
# @doc: list article
# redis list

get '/listarticles' do
  # FIXME: Rewrite
  article = <<-ARTICLE
  <h1><center>List Articles</center></h1> </br>
  ARTICLE
  Dir.entries(Articles).select {|p| p[0] != "." }.each {|a| article << "<a href=\"articles/#{a}\"> #{a} </a> <br />\n"}
  #pp article

  article
end

get '/:year/:month/:day' do
  "#{params['year']}-#{params['month']}-#{params['day']}'s Articles."
end

# Use redis hash, mysql (with datetime author...)
get '/articles/:name' do
  # articles/2015-05-20_hello.md
  article_name = "./articles/#{params[:name]}"
  if File.readable? article_name
    article = redis.get(article_name)
    pp article
    article ||= File.read(article_name)
    redis.set article_name, article
    # FIXME: Here Document Problem
    <<-ARTICLE
    You get artile #{params['name']}!

    Article is:
    #{markdown article}
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
