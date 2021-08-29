require 'rubygems'
require 'bundler/setup'

require 'json'
require 'singleton'

Bundler.require(:default)

require 'pry' # TODO: remove
require 'tty-prompt'

module Models; end

require './app/models/user'
require './app/models/organization'
require './app/models/ticket'
require './app/models'
require './app/selection_database'
require './app/input'
require './app/output'
require './app/search_controller'
