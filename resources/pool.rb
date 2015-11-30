#
# Cookbook Name:: L7-memcached
# Provider:: pool
#
# Copyright 2015, Gabor Szelcsanyi <szelcsanyi.gabor@gmail.com>

actions :create, :remove

attribute :name, kind_of: String, name_attribute: true
attribute :cookbook, kind_of: String, default: 'L7-memcached'
attribute :tcp_port, kind_of: [Integer, String], default: '11211'
attribute :udp_port, kind_of: [Integer, String], default: '0'
attribute :listen, kind_of: [Integer, String], default: '127.0.0.1'
attribute :connection_limit, kind_of: [Integer, String], default: '1024'
attribute :size, kind_of: [Integer, String], default: '16'

attribute :repcache_port, kind_of: [Integer, String, NilClass], default: nil
attribute :repcache_listen, kind_of: [String, NilClass], default: nil

attribute :verbose, kind_of: [String, NilClass], default: nil

def initialize(*args)
  super
  @action = :create
end
