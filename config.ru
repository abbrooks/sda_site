require 'rubygems'
require 'sinatra'

env = ENV['RAILS_ENV'] || 'development'
set :environment, env.to_sym
disable :run, :reload

require File.dirname(__FILE__) + "/sd-web.rb"

run SDWeb
