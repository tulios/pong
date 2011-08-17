# encoding: utf-8

module Pong
  module States
    class Menu < Chingu::GameState

      include Chingu

      def initialize
        super
        Text.create(:text=>"PONG", :x => 20, :y => 20, :size => 100)

        Text.create(:text=>"Press:", :x => 20, :y => 120, :size => 50)
        Text.create(:text=>"ENTER to start", :x => 60, :y => 170, :size => 30, :color => Pong::BLUE)
        Text.create(:text=>"ESC to exit", :x => 60, :y => 200, :size => 30, :color => Pong::RED)

        self.input = {
          :escape => :exit,
          :enter => Pong::States::Level,
          :return => Pong::States::Level
        }
      end

    end
  end
end