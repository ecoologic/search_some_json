require 'rubygems'
require 'bundler/setup'

require 'json'
require 'singleton'

Bundler.require(:default)

require 'pry' # TODO: remove
require 'tty-prompt'

module Models; end
module Models::Users; end

require './app/models/users/decorator'
require './app/models/query'
require './app/input'
require './app/output'
require './app/search_controller'
