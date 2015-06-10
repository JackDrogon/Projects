#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

# Need 4 templates
# 1. get => 生成二维码界面
# 2. get => 听声音的界面
# 3. get => 录音的界面
# 4. get => 下载

# 为了减轻服务端压力，这里没有什么流量经过服务端，下载与上传都是经过七牛

require 'sinatra'

get '/static/:audio_url' do
end
