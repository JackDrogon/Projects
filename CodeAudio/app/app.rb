#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

# Need 4 templates
# 1. get => 生成二维码界面
# 2. get => 听声音的界面
# 3. get => 录音的界面
# 4. get => 下载

# 为了减轻服务端压力，这里没有什么流量经过服务端，下载与上传都是经过七牛

require 'sinatra'

get '/audio/static/:audio_url' do
  # audio.html
end

get '/audio/record' do
end

get '/api/token' do
  # 如何在此处验证文件大小和播放时间
  filename = params['filename'] # 上传的文件名
  token = "" # 上传token
  url = "" # 用于生成二维码
  # 生成json返回
  # 写入redis, filename, url
end
