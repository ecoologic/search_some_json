require 'rubygems'
require 'bundler/setup'
require 'json'

Bundler.require(:default)

require 'pry' # TODO: remove
require 'tty-prompt'

require './app/search_controller'
require './app/input'
require './app/output'
require './app/query'
