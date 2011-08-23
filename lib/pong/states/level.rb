# encoding: utf-8

module Pong
  module States
    class Level < Chingu::GameState

      include Chingu

      def initialize options = {}
        super
        @player = options.delete(:player)
        @player.plot_score!

        @bar = Bar.create :player => @player
        @ball = Ball.create :bar => @bar
        @bar.define_inputs!

        Block.plot!(15 + rand(10))

        self.input = {
          :escape => :exit,
          :f1 => lambda { @ball.reset_position! }
        }
      end

      def update
        super
        push_game_state Pong::States::GameOver if @ball.reach_bottom?
        push_game_state Pong::States::Victory if Block.all_destroyed?
      end

    end
  end
end