#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'zlib'

module Bitcask
  class Key
    attr_reader :file_id, :tstamp, :key, :value, :value_pos, :length
    def initialize(file_id, key, value)
      @file_id = file_id
      @key = key
      @value = value
      @tstamp = Time.now.to_i
      @value_pos = file_id.tell
      @length = Marshal.dump(self)

      file_id.print Marshal.dump(self)
    end

    def read(file_id, key)
      f.seek key.value_pos
      Marshal.load(f.read k.length).value
    end

    def to_s()
      "#{crc}#{@tstamp}#{@key.size}#{@value.size}#{@key}#{@value}"
    end

    def inspect()
      to_s
    end

    def crc()
      Zlib::crc32 "#{@tstamp}#{@key.size}#{@value.size}#{@key}#{@value}"
    end
  end

  class Cache
  end

  class Base
    def initialize(dirname)
      @dirname = dirname
      unless Dir.exist?(dirname)
        Dir.mkdir dirname
      end

      files = Dir.glob("#{dirname}/*.bitcask.data")
      if files
        file_id = files.map {|d| d.split(".")[0]}.sort[0] + 1
      else
        file_id = 0
      end

      @file = File.open "#{dirname}/#{file_id}.bitcask.data"
      @hash = {}
    end

    def set(key, value)
      @hash[key] = Key.new @file, key, value
    end

    def get(key)
      @hash[key].read
    end

    alias :'[]=' :set
    alias :'[]' :get
  end
end

bitcask = Bitcask::Base.new 'hello'
