#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'socket'
require 'pp'

class Memcache
  def initialize(settings)
    @tcp_server = TCPServer.new settings[:port]
    @clsid = 0
    @stop = false
    @hash_table = Hash.new
    @commands = {}
    [:ping, :set, :get, :delete, :quit].each {|command| @commands[command] = command}
    @mutex = Mutex.new
  end

  def start()
    #Thread.start(@tcp_server.accept) do |client|
    loop do
      client = @tcp_server.accept
      until @stop
        command = client.gets.split
        pp command
        process_command(client, command)
      end
    end
  end

  def ping(client, command)
    client.print "PONG\r\n"
  end

  def set(client, command)
    ## command = ["set", key, flags, expire_time, value_length]
    value = client.gets
    @hash_table[command[1]] = value
    client.print "STORED\r\n"
  end

  def get(client, command)
    value = @hash_table[command[1]]
    if value
      client.print "#{value}"
    else
      client.print "NOT_FOUND\r\n"
    end
  end

  def delete(client, command)
    @hash_table[command[1]] = nil
    client.print "SUCCESS\r\n"
  end

  def quit(client, command)
    client.close
    @stop = true
  end

  def process_command(client, command)
    if @commands[command[0].to_sym]
      self.send(@commands[command[0].to_sym], client, command)
    else
      client.close
      @stop = true
    end
  end
end

memcache = Memcache.new port: 11211
memcache.start
