# encoding: utf-8

module Pong
  module States
    class GameOver < Chingu::GameState

      include Chingu

      def initialize
        super

        @txt_game_over = Text.create(:text=>"Game Over!", :size => 100)

        pos_x = ((Pong.width - @txt_game_over.width) / 2)
        pos_y = ((Pong.height - @txt_game_over.height) / 2) - 50

        @txt_game_over.x = pos_x
        @txt_game_over.y = pos_y

        Text.create(:text=>"Press ESC", :x => 20, :y => Pong.height - 50, :size => 30, :color => Pong::RED)

        self.input = {
          :escape => Pong::States::Menu
        }
      end

    end
  end
end