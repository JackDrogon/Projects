#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'qiniu'

Qiniu.establish_connection! :access_key => '<YOUR_APP_ACCESS_KEY>',
                            :secret_key => '<YOUR_APP_SECRET_KEY>'
