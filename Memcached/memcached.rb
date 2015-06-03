#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'socket'
require 'pp'

class Memcache

  def initialize(settings)
    @tcp_server = TCPServer.new settings[:port]
    @hash_table = Hash.new
  end

  def start()
    #Thread.start(@tcp_server.accept) do |client|
    loop do
      client = @tcp_server.accept
      client.puts "Hello!"

      stop = false

      until stop
        command = client.gets.split
        pp command
        case command[0]
        when "set"
          value = client.gets
          @hash_table[command[1]] = value
          client.print "STORED\r\n"
        when "get"
          value = @hash_table[command[1]]
          if value
            client.print "#{value}"
          else
            client.print "NOT_FOUND\r\n"
          end
        when "delete"
          @hash_table[command[1]] = nil
          client.print "SUCCESS\r\n"
        when "quit"
          client.close
          stop = true
        else
          client.close
          stop = true
        end
      end
    end
  end

end

memcache = Memcache.new port: 11211
memcache.start
