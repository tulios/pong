# encoding: utf-8

require 'yaml'

require_relative 'pong/game'

require_relative 'pong/elements/bar'
require_relative 'pong/elements/ball'
require_relative 'pong/elements/block'
require_relative 'pong/elements/player'
require_relative 'pong/elements/power_up'

require_relative 'pong/states/menu'
require_relative 'pong/states/level'
require_relative 'pong/states/game_over'
require_relative 'pong/states/victory'

module Pong

  include Gosu
  include Chingu

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

    def text_to_image text
      Gosu::Image.from_text($window, text.text, text.gosu_font.name, text.gosu_font.height)
    end

  end

end