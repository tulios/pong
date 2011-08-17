# encoding: utf-8

module Pong
  module States
    class Level < Chingu::GameState

      include Chingu

      def initialize
        super
        @bar = Bar.create
        @ball = Ball.create
        @bar.define_inputs!

        self.input = {
          :escape => :exit,
          :f1 => lambda { @ball.reset_position! }
        }
      end

      def update
        super
        push_game_state Pong::States::GameOver if @ball.reach_bottom?
      end

    end
  end
end