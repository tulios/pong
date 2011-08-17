# encoding: utf-8

require 'yaml'
require_relative 'pong/game'

require_relative 'pong/elements/bar'
require_relative 'pong/elements/ball'

require_relative 'pong/states/menu'
require_relative 'pong/states/level'
require_relative 'pong/states/game_over'

module Pong

  include Gosu

  @@settings_path = File.expand_path(File.join(File.dirname(__FILE__), "..", "config", "settings.yml"))
  @@config = YAML.load_file(@@settings_path)

  RED = Color.new(0xFFCC3333)
  BLUE = Color.new(0xFF0066CC)

  class << self

    def config; @@config end

    def width
      @width ||= config["general"]["width"]
    end

    def height
      @height ||= config["general"]["height"]
    end

  end

end