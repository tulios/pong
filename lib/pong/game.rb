# encoding: utf-8

module Pong

  class Game < Chingu::Window

    def initialize
      super Pong.width, Pong.height
      push_game_state Pong::States::Menu
    end

    def update
      super
      self.caption = "FPS: #{self.fps} milliseconds_since_last_tick: #{self.milliseconds_since_last_tick}"
    end

  end

end













