# encoding: utf-8

module Pong
  module States
    class Victory < Chingu::GameState

      include Chingu

      def initialize
        super

        Block.destroy_all

        @txt_victory = Text.create(:text=>"Victory!", :size => 100)

        pos_x = ((Pong.width - @txt_victory.width) / 2)
        pos_y = ((Pong.height - @txt_victory.height) / 2) - 50

        @txt_victory.x = pos_x
        @txt_victory.y = pos_y

        Text.create(:text=>"Press ESC", :x => 20, :y => Pong.height - 50, :size => 30, :color => Pong::BLUE)

        self.input = {
          :escape => lambda { switch_game_state Pong::States::Menu }
        }
      end

    end
  end
end