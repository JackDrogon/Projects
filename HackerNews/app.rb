#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'sinatra'
require "sinatra/reloader" if development?
require 'rdiscount'
require 'tilt/erubis'
require 'redis'

require_relative 'app_config'

# TODO: Add logger
# TODO: Compare redis value && artitle time, update artitle
# TODO: redis just as cache
# TODO: 添加文章的静态化, 去除redis

redis = Redis.new RedisServerOption

# TODO: add proc, when value is nil, use proc to generate value
def get_key(key)
end

get '/' do
  content_type :txt
  'Welcome to HackerNews.'
end

get '/env' do
  env.inspect
end

## Blog
# @doc: list article
# redis list

get '/articles' do
  # FIXME: Rewrite
  article = <<-ARTICLE
  <h1><center>List Articles</center></h1> </br>
  ARTICLE
  Dir.entries(Articles).select {|p| p[0] != "." }.sort {|a, b| b <=> a}.each {|a| article << "<a href=\"articles/#{a}\"> #{a} </a> <br />\n"}
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
    # pp article
    article ||= markdown(File.read(article_name))
    redis.set article_name, article
    # FIXME: Here Document Problem
    # You get artitle #{params['name']}!<br \>
    @article = <<-ARTICLE
    Article is:
    #{article}
    ARTICLE
    erb :blog
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

__END__

@@blog

<h1> Blog </h1>
<%= @article %>
