# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

require 'json'
require 'singleton'

Bundler.require(:default)

# require 'pry'
require 'tty-prompt'

module Models; end

require './app/error_messages'
require './app/models/base'
require './app/models/user'
require './app/models/organization'
require './app/models/ticket'
require './app/models'
require './app/selection_database'
require './app/input'
require './app/output'
require './app/search_controller'
