# encoding: utf-8

require "rubygems"
require "bundler/setup"

Bundler.require(:default)

require_relative 'lib/pong'

Pong::Game.new.show